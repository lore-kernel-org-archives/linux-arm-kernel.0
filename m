From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 15 Jun 2010 13:11:30 -0600
Subject: [PATCH 08/12] ptp: Added a brand new class driver for ptp clocks.
In-Reply-To: <4a030d2bace90f089f2f3f61496b918c6f1dfb52.1276615626.git.richard.cochran@omicron.at>
References: <cover.1276615626.git.richard.cochran@omicron.at>
	<4a030d2bace90f089f2f3f61496b918c6f1dfb52.1276615626.git.richard.cochran@omicron.at>
Message-ID: <AANLkTinYjzfChsN0AB5W6kOh6xJYPJtoEq941pG8WbmS@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 15, 2010 at 10:09 AM, Richard Cochran
<richardcochran@gmail.com> wrote:
> This patch adds an infrastructure for hardware clocks that implement
> IEEE 1588, the Precision Time Protocol (PTP). A class driver offers a
> registration method to particular hardware clock drivers. Each clock is
> exposed to user space as a character device with ioctls that allow tuning
> of the PTP clock.
>
> Signed-off-by: Richard Cochran <richard.cochran@omicron.at>

Hi Richard,

Some more comments on this patch...

> ---
> ?Documentation/ptp/ptp.txt ? ? ? ?| ? 95 +++++++
> ?Documentation/ptp/testptp.c ? ? ?| ?269 ++++++++++++++++++++
> ?Documentation/ptp/testptp.mk ? ? | ? 33 +++
> ?drivers/Kconfig ? ? ? ? ? ? ? ? ?| ? ?2 +
> ?drivers/Makefile ? ? ? ? ? ? ? ? | ? ?1 +
> ?drivers/ptp/Kconfig ? ? ? ? ? ? ?| ? 26 ++
> ?drivers/ptp/Makefile ? ? ? ? ? ? | ? ?5 +
> ?drivers/ptp/ptp_clock.c ? ? ? ? ?| ?514 ++++++++++++++++++++++++++++++++++++++
> ?include/linux/Kbuild ? ? ? ? ? ? | ? ?1 +
> ?include/linux/ptp_clock.h ? ? ? ?| ? 79 ++++++
> ?include/linux/ptp_clock_kernel.h | ?137 ++++++++++
> ?11 files changed, 1162 insertions(+), 0 deletions(-)
> ?create mode 100644 Documentation/ptp/ptp.txt
> ?create mode 100644 Documentation/ptp/testptp.c
> ?create mode 100644 Documentation/ptp/testptp.mk
> ?create mode 100644 drivers/ptp/Kconfig
> ?create mode 100644 drivers/ptp/Makefile
> ?create mode 100644 drivers/ptp/ptp_clock.c
> ?create mode 100644 include/linux/ptp_clock.h
> ?create mode 100644 include/linux/ptp_clock_kernel.h
>
> diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
> new file mode 100644
> index 0000000..b86695c
> --- /dev/null
> +++ b/drivers/ptp/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for PTP 1588 clock support.
> +#
> +
> +obj-$(CONFIG_PTP_1588_CLOCK) ? ? ? ? ? += ptp_clock.o
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> new file mode 100644
> index 0000000..4753bf3
> --- /dev/null
> +++ b/drivers/ptp/ptp_clock.c
> @@ -0,0 +1,514 @@
> +/*
> + * PTP 1588 clock support
> + *
> + * Partially adapted from the Linux PPS driver.
> + *
> + * Copyright (C) 2010 OMICRON electronics GmbH
> + *
> + * ?This program is free software; you can redistribute it and/or modify
> + * ?it under the terms of the GNU General Public License as published by
> + * ?the Free Software Foundation; either version 2 of the License, or
> + * ?(at your option) any later version.
> + *
> + * ?This program is distributed in the hope that it will be useful,
> + * ?but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * ?MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
> + * ?GNU General Public License for more details.
> + *
> + * ?You should have received a copy of the GNU General Public License
> + * ?along with this program; if not, write to the Free Software
> + * ?Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +#include <linux/bitops.h>
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/poll.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +
> +#include <linux/ptp_clock_kernel.h>
> +#include <linux/ptp_clock.h>
> +
> +#define PTP_MAX_ALARMS 4
> +#define PTP_MAX_CLOCKS BITS_PER_LONG
> +#define PTP_MAX_TIMESTAMPS 128
> +
> +struct alarm {
> + ? ? ? struct pid *pid;
> + ? ? ? int sig;
> +};
> +
> +struct timestamp_event_queue {
> + ? ? ? struct ptp_extts_event buf[PTP_MAX_TIMESTAMPS];
> + ? ? ? int head;
> + ? ? ? int tail;
> + ? ? ? int overflow;
> +};
> +
> +struct ptp_clock {
> + ? ? ? struct list_head list;
> + ? ? ? struct cdev cdev;
> + ? ? ? struct device *dev;
> + ? ? ? struct ptp_clock_info *info;
> + ? ? ? dev_t devid;
> + ? ? ? int index; /* index into clocks.map, also the minor number */
> +
> + ? ? ? struct alarm alarm[PTP_MAX_ALARMS];
> + ? ? ? struct mutex alarm_mux; /* one process at a time setting an alarm */
> +
> + ? ? ? struct timestamp_event_queue tsevq; /* simple fifo for time stamps */
> + ? ? ? struct mutex tsevq_mux; /* one process at a time reading the fifo */
> + ? ? ? wait_queue_head_t tsev_wq;
> +};
> +
> +/* private globals */
> +
> +static const struct file_operations ptp_fops;
> +static dev_t ptp_devt;
> +static struct class *ptp_class;
> +
> +static struct {
> + ? ? ? struct list_head list;
> + ? ? ? DECLARE_BITMAP(map, PTP_MAX_CLOCKS);
> +} clocks;
> +static DEFINE_SPINLOCK(clocks_lock); /* protects 'clocks' */

Doesn't appear that clocks is manipulated at atomic context.  Mutex instead?

> +
> +/* time stamp event queue operations */
> +
> +static inline int queue_cnt(struct timestamp_event_queue *q)
> +{
> + ? ? ? int cnt = q->tail - q->head;
> + ? ? ? return cnt < 0 ? PTP_MAX_TIMESTAMPS + cnt : cnt;
> +}
> +
> +static inline int queue_free(struct timestamp_event_queue *q)
> +{
> + ? ? ? return PTP_MAX_TIMESTAMPS - queue_cnt(q) - 1;
> +}
> +
> +static void enqueue_external_timestamp(struct timestamp_event_queue *queue,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct ptp_clock_event *src)
> +{
> + ? ? ? struct ptp_extts_event *dst;
> + ? ? ? u32 remainder;
> +
> + ? ? ? dst = &queue->buf[queue->tail];
> +
> + ? ? ? dst->index = src->index;
> + ? ? ? dst->ts.tv_sec = div_u64_rem(src->timestamp, 1000000000, &remainder);
> + ? ? ? dst->ts.tv_nsec = remainder;
> +
> + ? ? ? if (!queue_free(queue))
> + ? ? ? ? ? ? ? queue->overflow++;
> +
> + ? ? ? queue->tail = (queue->tail + 1) % PTP_MAX_TIMESTAMPS;
> +}
> +
> +/* public interface */
> +
> +struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info)
> +{
> + ? ? ? struct ptp_clock *ptp;
> + ? ? ? int err = 0, index, major = MAJOR(ptp_devt);
> + ? ? ? unsigned long flags;
> +
> + ? ? ? if (info->n_alarm > PTP_MAX_ALARMS)
> + ? ? ? ? ? ? ? return ERR_PTR(-EINVAL);

Okay, this is my opinion here, and other maintainers may disagree with
me, but the ERR_PTR() pattern is a horrible idea.  It is non-obvious
when reading code when the pattern is used, and the compiler will not
catch misinterpretation of the return value for you.  Please don't add
new instances of using it.  Just return NULL on error and log it with
printk() or pr_error().  Very seldom do I find the actual error code
to be actually useful anyway.  Generally callers only care about
whether or not the operation succeeded.

> +
> + ? ? ? /* Find a free clock slot and reserve it. */
> + ? ? ? err = -EBUSY;
> + ? ? ? spin_lock_irqsave(&clocks_lock, flags);
> + ? ? ? index = find_first_zero_bit(clocks.map, PTP_MAX_CLOCKS);
> + ? ? ? if (index < PTP_MAX_CLOCKS) {
> + ? ? ? ? ? ? ? set_bit(index, clocks.map);
> + ? ? ? ? ? ? ? spin_unlock_irqrestore(&clocks_lock, flags);
> + ? ? ? } else {
> + ? ? ? ? ? ? ? spin_unlock_irqrestore(&clocks_lock, flags);
> + ? ? ? ? ? ? ? goto no_clock;
> + ? ? ? }

If the spinlock is changed to a mutex that is held for the entire
function call, then the logic here can be simpler.

> +
> + ? ? ? /* Initialize a clock structure. */
> + ? ? ? err = -ENOMEM;
> + ? ? ? ptp = kzalloc(sizeof(struct ptp_clock), GFP_KERNEL);
> + ? ? ? if (ptp == NULL)
> + ? ? ? ? ? ? ? goto no_memory;
> +
> + ? ? ? ptp->info = info;
> + ? ? ? ptp->devid = MKDEV(major, index);
> + ? ? ? ptp->index = index;
> + ? ? ? mutex_init(&ptp->alarm_mux);
> + ? ? ? mutex_init(&ptp->tsevq_mux);
> + ? ? ? init_waitqueue_head(&ptp->tsev_wq);
> +
> + ? ? ? /* Create a new device in our class. */
> + ? ? ? ptp->dev = device_create(ptp_class, NULL, ptp->devid, ptp,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"ptp_clock_%d", ptp->index);
> + ? ? ? if (IS_ERR(ptp->dev))
> + ? ? ? ? ? ? ? goto no_device;
> +
> + ? ? ? dev_set_drvdata(ptp->dev, ptp);
> +
> + ? ? ? /* Register a character device. */
> + ? ? ? cdev_init(&ptp->cdev, &ptp_fops);
> + ? ? ? ptp->cdev.owner = info->owner;
> + ? ? ? err = cdev_add(&ptp->cdev, ptp->devid, 1);
> + ? ? ? if (err)
> + ? ? ? ? ? ? ? goto no_cdev;
> +
> + ? ? ? /* Clock is ready, add it into the list. */
> + ? ? ? spin_lock_irqsave(&clocks_lock, flags);
> + ? ? ? list_add(&ptp->list, &clocks.list);
> + ? ? ? spin_unlock_irqrestore(&clocks_lock, flags);
> +
> + ? ? ? return ptp;
> +
> +no_cdev:
> + ? ? ? device_destroy(ptp_class, ptp->devid);
> +no_device:
> + ? ? ? mutex_destroy(&ptp->alarm_mux);
> + ? ? ? mutex_destroy(&ptp->tsevq_mux);
> + ? ? ? kfree(ptp);
> +no_memory:
> + ? ? ? spin_lock_irqsave(&clocks_lock, flags);
> + ? ? ? clear_bit(index, clocks.map);
> + ? ? ? spin_unlock_irqrestore(&clocks_lock, flags);
> +no_clock:
> + ? ? ? return ERR_PTR(err);
> +}
> +EXPORT_SYMBOL(ptp_clock_register);
> +
> +int ptp_clock_unregister(struct ptp_clock *ptp)
> +{
> + ? ? ? unsigned long flags;
> +
> + ? ? ? /* Release the clock's resources. */
> + ? ? ? cdev_del(&ptp->cdev);
> + ? ? ? device_destroy(ptp_class, ptp->devid);
> + ? ? ? mutex_destroy(&ptp->alarm_mux);
> + ? ? ? mutex_destroy(&ptp->tsevq_mux);
> +
> + ? ? ? /* Remove the clock from the list. */
> + ? ? ? spin_lock_irqsave(&clocks_lock, flags);
> + ? ? ? list_del(&ptp->list);
> + ? ? ? clear_bit(ptp->index, clocks.map);
> + ? ? ? spin_unlock_irqrestore(&clocks_lock, flags);
> +
> + ? ? ? kfree(ptp);
> +
> + ? ? ? return 0;
> +}
> +EXPORT_SYMBOL(ptp_clock_unregister);
> +
> +void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
> +{
> + ? ? ? switch (event->type) {
> +
> + ? ? ? case PTP_CLOCK_ALARM:
> + ? ? ? ? ? ? ? kill_pid(ptp->alarm[event->index].pid,
> + ? ? ? ? ? ? ? ? ? ? ? ?ptp->alarm[event->index].sig, 1);
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case PTP_CLOCK_EXTTS:
> + ? ? ? ? ? ? ? enqueue_external_timestamp(&ptp->tsevq, event);
> + ? ? ? ? ? ? ? wake_up_interruptible(&ptp->tsev_wq);
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case PTP_CLOCK_PPS:
> + ? ? ? ? ? ? ? break;
> + ? ? ? }
> +}
> +EXPORT_SYMBOL(ptp_clock_event);
> +
> +/* character device operations */
> +
> +static int ptp_ioctl(struct inode *node, struct file *fp,
> + ? ? ? ? ? ? ? ? ? ? unsigned int cmd, unsigned long arg)
> +{
> + ? ? ? struct ptp_clock_caps caps;
> + ? ? ? struct ptp_clock_request req;
> + ? ? ? struct ptp_clock_timer timer;
> + ? ? ? struct ptp_clock *ptp = fp->private_data;
> + ? ? ? struct ptp_clock_info *ops = ptp->info;
> + ? ? ? void *priv = ops->priv;
> + ? ? ? struct timespec ts;
> + ? ? ? int flags, index;
> + ? ? ? int err = 0;
> +
> + ? ? ? switch (cmd) {
> +
> + ? ? ? case PTP_CLOCK_APIVERS:
> + ? ? ? ? ? ? ? err = put_user(PTP_CLOCK_VERSION, (u32 __user *)arg);
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case PTP_CLOCK_ADJFREQ:
> + ? ? ? ? ? ? ? if (!capable(CAP_SYS_TIME))
> + ? ? ? ? ? ? ? ? ? ? ? return -EPERM;
> + ? ? ? ? ? ? ? err = ops->adjfreq(priv, arg);
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case PTP_CLOCK_ADJTIME:
> + ? ? ? ? ? ? ? if (!capable(CAP_SYS_TIME))
> + ? ? ? ? ? ? ? ? ? ? ? return -EPERM;
> + ? ? ? ? ? ? ? if (copy_from_user(&ts, (void __user *)arg, sizeof(ts)))
> + ? ? ? ? ? ? ? ? ? ? ? err = -EFAULT;
> + ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? ? ? ? ? err = ops->adjtime(priv, &ts);
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case PTP_CLOCK_GETTIME:
> + ? ? ? ? ? ? ? err = ops->gettime(priv, &ts);
> + ? ? ? ? ? ? ? if (err)
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? err = copy_to_user((void __user *)arg, &ts, sizeof(ts));
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case PTP_CLOCK_SETTIME:
> + ? ? ? ? ? ? ? if (!capable(CAP_SYS_TIME))
> + ? ? ? ? ? ? ? ? ? ? ? return -EPERM;
> + ? ? ? ? ? ? ? if (copy_from_user(&ts, (void __user *)arg, sizeof(ts)))
> + ? ? ? ? ? ? ? ? ? ? ? err = -EFAULT;
> + ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? ? ? ? ? err = ops->settime(priv, &ts);
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case PTP_CLOCK_GETCAPS:
> + ? ? ? ? ? ? ? memset(&caps, 0, sizeof(caps));
> + ? ? ? ? ? ? ? caps.max_adj = ptp->info->max_adj;
> + ? ? ? ? ? ? ? caps.n_alarm = ptp->info->n_alarm;
> + ? ? ? ? ? ? ? caps.n_ext_ts = ptp->info->n_ext_ts;
> + ? ? ? ? ? ? ? caps.n_per_out = ptp->info->n_per_out;
> + ? ? ? ? ? ? ? caps.pps = ptp->info->pps;
> + ? ? ? ? ? ? ? err = copy_to_user((void __user *)arg, &caps, sizeof(caps));
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case PTP_CLOCK_GETTIMER:
> + ? ? ? ? ? ? ? if (copy_from_user(&timer, (void __user *)arg, sizeof(timer))) {
> + ? ? ? ? ? ? ? ? ? ? ? err = -EFAULT;
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? index = timer.alarm_index;
> + ? ? ? ? ? ? ? if (index < 0 || index >= ptp->info->n_alarm) {
> + ? ? ? ? ? ? ? ? ? ? ? err = -EINVAL;
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? err = ops->gettimer(priv, index, &timer.tsp);
> + ? ? ? ? ? ? ? if (err)
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? err = copy_to_user((void __user *)arg, &timer, sizeof(timer));
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case PTP_CLOCK_SETTIMER:
> + ? ? ? ? ? ? ? if (copy_from_user(&timer, (void __user *)arg, sizeof(timer))) {
> + ? ? ? ? ? ? ? ? ? ? ? err = -EFAULT;
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? index = timer.alarm_index;
> + ? ? ? ? ? ? ? if (index < 0 || index >= ptp->info->n_alarm) {
> + ? ? ? ? ? ? ? ? ? ? ? err = -EINVAL;
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? if (!valid_signal(timer.signum))
> + ? ? ? ? ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? ? ? ? ? flags = timer.flags;
> + ? ? ? ? ? ? ? if (flags & (flags != TIMER_ABSTIME)) {
> + ? ? ? ? ? ? ? ? ? ? ? err = -EINVAL;
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? if (mutex_lock_interruptible(&ptp->alarm_mux))
> + ? ? ? ? ? ? ? ? ? ? ? return -ERESTARTSYS;
> +
> + ? ? ? ? ? ? ? if (ptp->alarm[index].pid)
> + ? ? ? ? ? ? ? ? ? ? ? put_pid(ptp->alarm[index].pid);
> +
> + ? ? ? ? ? ? ? ptp->alarm[index].pid = get_pid(task_pid(current));
> + ? ? ? ? ? ? ? ptp->alarm[index].sig = timer.signum;
> + ? ? ? ? ? ? ? err = ops->settimer(priv, index, flags, &timer.tsp);
> +
> + ? ? ? ? ? ? ? mutex_unlock(&ptp->alarm_mux);
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case PTP_FEATURE_REQUEST:
> + ? ? ? ? ? ? ? if (copy_from_user(&req, (void __user *)arg, sizeof(req))) {
> + ? ? ? ? ? ? ? ? ? ? ? err = -EFAULT;
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? switch (req.type) {
> + ? ? ? ? ? ? ? case PTP_REQUEST_EXTTS:
> + ? ? ? ? ? ? ? case PTP_REQUEST_PEROUT:
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? case PTP_REQUEST_PPS:
> + ? ? ? ? ? ? ? ? ? ? ? if (!capable(CAP_SYS_TIME))
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? return -EPERM;
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? default:
> + ? ? ? ? ? ? ? ? ? ? ? err = -EINVAL;
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? if (err)
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? err = ops->enable(priv, &req,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? req.flags & PTP_ENABLE_FEATURE ? 1 : 0);
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? default:
> + ? ? ? ? ? ? ? err = -ENOTTY;
> + ? ? ? ? ? ? ? break;
> + ? ? ? }
> + ? ? ? return err;
> +}
> +
> +static int ptp_open(struct inode *inode, struct file *fp)
> +{
> + ? ? ? struct ptp_clock *ptp;
> + ? ? ? ptp = container_of(inode->i_cdev, struct ptp_clock, cdev);
> +
> + ? ? ? fp->private_data = ptp;
> +
> + ? ? ? return 0;
> +}
> +
> +static unsigned int ptp_poll(struct file *fp, poll_table *wait)
> +{
> + ? ? ? struct ptp_clock *ptp = fp->private_data;
> +
> + ? ? ? poll_wait(fp, &ptp->tsev_wq, wait);
> +
> + ? ? ? return queue_cnt(&ptp->tsevq) ? POLLIN : 0;
> +}
> +
> +static ssize_t ptp_read(struct file *fp, char __user *buf,
> + ? ? ? ? ? ? ? ? ? ? ? size_t cnt, loff_t *off)
> +{
> + ? ? ? struct ptp_clock *ptp = fp->private_data;
> + ? ? ? struct timestamp_event_queue *queue = &ptp->tsevq;
> + ? ? ? struct ptp_extts_event *event;
> + ? ? ? size_t qcnt;
> +
> + ? ? ? if (mutex_lock_interruptible(&ptp->tsevq_mux))
> + ? ? ? ? ? ? ? return -ERESTARTSYS;
> +
> + ? ? ? cnt = cnt / sizeof(struct ptp_extts_event);
> +
> + ? ? ? if (wait_event_interruptible(ptp->tsev_wq,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(qcnt = queue_cnt(&ptp->tsevq)))) {
> + ? ? ? ? ? ? ? mutex_unlock(&ptp->tsevq_mux);
> + ? ? ? ? ? ? ? return -ERESTARTSYS;
> + ? ? ? }
> +
> + ? ? ? if (cnt > qcnt)
> + ? ? ? ? ? ? ? cnt = qcnt;
> +
> + ? ? ? event = &queue->buf[queue->head];
> +
> + ? ? ? if (copy_to_user(buf, event, cnt * sizeof(struct ptp_extts_event))) {
> + ? ? ? ? ? ? ? mutex_unlock(&ptp->tsevq_mux);
> + ? ? ? ? ? ? ? return -EFAULT;
> + ? ? ? }
> + ? ? ? queue->head = (queue->head + cnt) % PTP_MAX_TIMESTAMPS;
> +
> + ? ? ? mutex_unlock(&ptp->tsevq_mux);
> +
> + ? ? ? return cnt * sizeof(struct ptp_extts_event);
> +}
> +
> +static int ptp_release(struct inode *inode, struct file *fp)
> +{
> + ? ? ? struct ptp_clock *ptp;
> + ? ? ? struct itimerspec ts = {
> + ? ? ? ? ? ? ? {0, 0}, {0, 0}
> + ? ? ? };
> + ? ? ? int i;
> +
> + ? ? ? ptp = container_of(inode->i_cdev, struct ptp_clock, cdev);
> +
> + ? ? ? for (i = 0; i < ptp->info->n_alarm; i++) {
> + ? ? ? ? ? ? ? if (ptp->alarm[i].pid) {
> + ? ? ? ? ? ? ? ? ? ? ? ptp->info->settimer(ptp->info->priv, i, 0, &ts);
> + ? ? ? ? ? ? ? ? ? ? ? put_pid(ptp->alarm[i].pid);
> + ? ? ? ? ? ? ? ? ? ? ? ptp->alarm[i].pid = NULL;
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> + ? ? ? return 0;
> +}
> +
> +static const struct file_operations ptp_fops = {
> + ? ? ? .owner ? ? ? ? ?= THIS_MODULE,
> + ? ? ? .ioctl ? ? ? ? ?= ptp_ioctl,
> + ? ? ? .open ? ? ? ? ? = ptp_open,
> + ? ? ? .poll ? ? ? ? ? = ptp_poll,
> + ? ? ? .read ? ? ? ? ? = ptp_read,
> + ? ? ? .release ? ? ? ?= ptp_release,
> +};
> +
> +/* sysfs */
> +
> +static ssize_t ptp_show_status(struct device *dev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct device_attribute *attr, char *buf)
> +{
> + ? ? ? struct ptp_clock *ptp = dev_get_drvdata(dev);
> + ? ? ? return sprintf(buf,
> + ? ? ? ? ? ? ? ? ? ? ?"maximum adjustment: ?%d\n"
> + ? ? ? ? ? ? ? ? ? ? ?"programmable alarms: %d\n"
> + ? ? ? ? ? ? ? ? ? ? ?"external timestamps: %d\n"
> + ? ? ? ? ? ? ? ? ? ? ?"periodic outputs: ? ?%d\n"
> + ? ? ? ? ? ? ? ? ? ? ?"has pps: ? ? ? ? ? ? %d\n"
> + ? ? ? ? ? ? ? ? ? ? ?"device index: ? ? ? ?%d\n",
> + ? ? ? ? ? ? ? ? ? ? ?ptp->info->max_adj,
> + ? ? ? ? ? ? ? ? ? ? ?ptp->info->n_alarm,
> + ? ? ? ? ? ? ? ? ? ? ?ptp->info->n_ext_ts,
> + ? ? ? ? ? ? ? ? ? ? ?ptp->info->n_per_out,
> + ? ? ? ? ? ? ? ? ? ? ?ptp->info->pps,
> + ? ? ? ? ? ? ? ? ? ? ?ptp->index);
> +}

Don't do this in a sysfs file.  Use a debugfs file if you want to
export freeform data like this.  sysfs files should contain either
only one value, or a simple list-of-same-type values.  Formatted data
is completely out.

> +
> +struct device_attribute ptp_attrs[] = {
> + ? ? ? __ATTR(capabilities, S_IRUGO, ptp_show_status, NULL),
> + ? ? ? __ATTR_NULL,
> +};
> +
> +/* module operations */
> +
> +static void __exit ptp_exit(void)
> +{
> + ? ? ? class_destroy(ptp_class);
> + ? ? ? unregister_chrdev_region(ptp_devt, PTP_MAX_CLOCKS);
> +}
> +
> +static int __init ptp_init(void)
> +{
> + ? ? ? int err;
> +
> + ? ? ? INIT_LIST_HEAD(&clocks.list);
> +
> + ? ? ? ptp_class = class_create(THIS_MODULE, "ptp");
> + ? ? ? if (!ptp_class) {
> + ? ? ? ? ? ? ? printk(KERN_ERR "ptp: failed to allocate class\n");
> + ? ? ? ? ? ? ? return -ENOMEM;
> + ? ? ? }
> + ? ? ? ptp_class->dev_attrs = ptp_attrs;
> +
> + ? ? ? err = alloc_chrdev_region(&ptp_devt, 0, PTP_MAX_CLOCKS, "ptp");
> + ? ? ? if (err < 0) {
> + ? ? ? ? ? ? ? printk(KERN_ERR "ptp: failed to allocate char device region\n");
> + ? ? ? ? ? ? ? goto no_region;
> + ? ? ? }
> +
> + ? ? ? pr_info("PTP clock support registered\n");
> + ? ? ? return 0;
> +
> +no_region:
> + ? ? ? class_destroy(ptp_class);
> + ? ? ? return err;
> +}
> +
> +subsys_initcall(ptp_init);
> +module_exit(ptp_exit);
> +
> +MODULE_AUTHOR("Richard Cochran <richard.cochran@omicron.at>");
> +MODULE_DESCRIPTION("PTP clocks support");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/Kbuild b/include/linux/Kbuild
> index 2fc8e14..9959fe4 100644
> --- a/include/linux/Kbuild
> +++ b/include/linux/Kbuild
> @@ -140,6 +140,7 @@ header-y += pkt_sched.h
> ?header-y += posix_types.h
> ?header-y += ppdev.h
> ?header-y += prctl.h
> +header-y += ptp_clock.h
> ?header-y += qnxtypes.h
> ?header-y += qnx4_fs.h
> ?header-y += radeonfb.h
> diff --git a/include/linux/ptp_clock.h b/include/linux/ptp_clock.h
> new file mode 100644
> index 0000000..5a509c5
> --- /dev/null
> +++ b/include/linux/ptp_clock.h
> @@ -0,0 +1,79 @@
> +/*
> + * PTP 1588 clock support - user space interface
> + *
> + * Copyright (C) 2010 OMICRON electronics GmbH
> + *
> + * ?This program is free software; you can redistribute it and/or modify
> + * ?it under the terms of the GNU General Public License as published by
> + * ?the Free Software Foundation; either version 2 of the License, or
> + * ?(at your option) any later version.
> + *
> + * ?This program is distributed in the hope that it will be useful,
> + * ?but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * ?MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
> + * ?GNU General Public License for more details.
> + *
> + * ?You should have received a copy of the GNU General Public License
> + * ?along with this program; if not, write to the Free Software
> + * ?Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#ifndef _PTP_CLOCK_H_
> +#define _PTP_CLOCK_H_
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +#define PTP_ENABLE_FEATURE (1<<0)
> +#define PTP_RISING_EDGE ? ?(1<<1)
> +#define PTP_FALLING_EDGE ? (1<<2)
> +
> +enum ptp_request_types {
> + ? ? ? PTP_REQUEST_EXTTS,
> + ? ? ? PTP_REQUEST_PEROUT,
> + ? ? ? PTP_REQUEST_PPS,
> +};
> +
> +struct ptp_clock_caps {
> + ? ? ? __s32 max_adj; /* Maximum frequency adjustment, parts per billon. */
> + ? ? ? int n_alarm; ? /* Number of programmable alarms. */
> + ? ? ? int n_ext_ts; ?/* Number of external time stamp channels. */
> + ? ? ? int n_per_out; /* Number of programmable periodic signals. */
> + ? ? ? int pps; ? ? ? /* Whether the clock supports a PPS callback. */
> +};
> +
> +struct ptp_clock_timer {
> + ? ? ? int alarm_index; ? ? ? /* Which alarm to query or configure. */
> + ? ? ? int signum; ? ? ? ? ? ?/* Requested signal. */
> + ? ? ? int flags; ? ? ? ? ? ? /* Zero or TIMER_ABSTIME, see TIMER_SETTIME(2) */
> + ? ? ? struct itimerspec tsp; /* See TIMER_SETTIME(2) */
> +};
> +
> +struct ptp_clock_request {
> + ? ? ? int type; ?/* One of the ptp_request_types enumeration values. */
> + ? ? ? int index; /* Which channel to configure. */
> + ? ? ? struct timespec ts; /* For period signals, the desired period. */
> + ? ? ? int flags; /* Bit field for PTP_ENABLE_FEATURE or other flags. */
> +};
> +
> +struct ptp_extts_event {
> + ? ? ? int index;
> + ? ? ? struct timespec ts;
> +};
> +
> +#define PTP_CLOCK_VERSION 0x00000001
> +
> +#define PTP_CLK_MAGIC '='
> +
> +#define PTP_CLOCK_APIVERS _IOR (PTP_CLK_MAGIC, 1, __u32)
> +#define PTP_CLOCK_ADJFREQ _IO ?(PTP_CLK_MAGIC, 2)
> +#define PTP_CLOCK_ADJTIME _IOW (PTP_CLK_MAGIC, 3, struct timespec)
> +#define PTP_CLOCK_GETTIME _IOR (PTP_CLK_MAGIC, 4, struct timespec)
> +#define PTP_CLOCK_SETTIME _IOW (PTP_CLK_MAGIC, 5, struct timespec)
> +
> +#define PTP_CLOCK_GETCAPS ? _IOR ?(PTP_CLK_MAGIC, 6, struct ptp_clock_caps)
> +#define PTP_CLOCK_GETTIMER ?_IOWR (PTP_CLK_MAGIC, 7, struct ptp_clock_timer)
> +#define PTP_CLOCK_SETTIMER ?_IOW ?(PTP_CLK_MAGIC, 8, struct ptp_clock_timer)
> +#define PTP_FEATURE_REQUEST _IOW ?(PTP_CLK_MAGIC, 9, struct ptp_clock_request)
> +
> +#endif
> diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
> new file mode 100644
> index 0000000..d6cc158
> --- /dev/null
> +++ b/include/linux/ptp_clock_kernel.h
> @@ -0,0 +1,137 @@
> +/*
> + * PTP 1588 clock support
> + *
> + * Copyright (C) 2010 OMICRON electronics GmbH
> + *
> + * ?This program is free software; you can redistribute it and/or modify
> + * ?it under the terms of the GNU General Public License as published by
> + * ?the Free Software Foundation; either version 2 of the License, or
> + * ?(at your option) any later version.
> + *
> + * ?This program is distributed in the hope that it will be useful,
> + * ?but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * ?MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
> + * ?GNU General Public License for more details.
> + *
> + * ?You should have received a copy of the GNU General Public License
> + * ?along with this program; if not, write to the Free Software
> + * ?Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#ifndef _PTP_CLOCK_KERNEL_H_
> +#define _PTP_CLOCK_KERNEL_H_
> +
> +#include <linux/ptp_clock.h>
> +
> +/**
> + * struct ptp_clock_info - decribes a PTP hardware clock
> + *
> + * @owner: ? ? The clock driver should set to THIS_MODULE.
> + * @name: ? ? ?A short name to identify the clock.
> + * @max_adj: ? The maximum possible frequency adjustment, in parts per billon.
> + * @n_alarm: ? The number of programmable alarms.
> + * @n_ext_ts: ?The number of external time stamp channels.
> + * @n_per_out: The number of programmable periodic signals.
> + * @pps: ? ? ? Indicates whether the clock supports a PPS callback.
> + * @priv: ? ? ?Passed to the clock operations, for the driver's private use.
> + *
> + * clock operations
> + *
> + * @adjfreq: ?Adjusts the frequency of the hardware clock.
> + * ? ? ? ? ? ?parameter delta: Desired period change in parts per billion.
> + *
> + * @adjtime: ?Shifts the time of the hardware clock.
> + * ? ? ? ? ? ?parameter ts: Desired change in seconds and nanoseconds.
> + *
> + * @gettime: ?Reads the current time from the hardware clock.
> + * ? ? ? ? ? ?parameter ts: Holds the result.
> + *
> + * @settime: ?Set the current time on the hardware clock.
> + * ? ? ? ? ? ?parameter ts: Time value to set.
> + *
> + * @gettimer: Reads the time remaining from the given timer.
> + * ? ? ? ? ? ?parameter index: Which alarm to query.
> + * ? ? ? ? ? ?parameter ts: Holds the result.
> + *
> + * @settimer: Arms the given timer for periodic or one shot operation.
> + * ? ? ? ? ? ?parameter index: Which alarm to set.
> + * ? ? ? ? ? ?parameter abs: TIMER_ABSTIME, or zero for relative timer.
> + * ? ? ? ? ? ?parameter ts: Alarm time and period to set.
> + *
> + * @enable: ? Request driver to enable or disable an ancillary feature.
> + * ? ? ? ? ? ?parameter request: Desired resource to enable or disable.
> + * ? ? ? ? ? ?parameter on: Caller passes one to enable or zero to disable.
> + *
> + * The callbacks must all return zero on success, non-zero otherwise.
> + */
> +
> +struct ptp_clock_info {
> + ? ? ? struct module *owner;
> + ? ? ? char name[16];
> + ? ? ? s32 max_adj;
> + ? ? ? int n_alarm;
> + ? ? ? int n_ext_ts;
> + ? ? ? int n_per_out;
> + ? ? ? int pps;
> + ? ? ? void *priv;
> + ? ? ? int (*adjfreq)(void *priv, s32 delta);
> + ? ? ? int (*adjtime)(void *priv, struct timespec *ts);
> + ? ? ? int (*gettime)(void *priv, struct timespec *ts);
> + ? ? ? int (*settime)(void *priv, struct timespec *ts);
> + ? ? ? int (*gettimer)(void *priv, int index, struct itimerspec *ts);
> + ? ? ? int (*settimer)(void *priv, int index, int abs, struct itimerspec *ts);
> + ? ? ? int (*enable)(void *priv, struct ptp_clock_request *request, int on);
> +};
> +
> +struct ptp_clock;
> +
> +/**
> + * ptp_clock_register() - register a PTP hardware clock driver
> + *
> + * @info: ?Structure describing the new clock.
> + */
> +
> +extern struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info);
> +
> +/**
> + * ptp_clock_unregister() - unregister a PTP hardware clock driver
> + *
> + * @ptp: ?The clock to remove from service.
> + */
> +
> +extern int ptp_clock_unregister(struct ptp_clock *ptp);
> +
> +
> +enum ptp_clock_events {
> + ? ? ? PTP_CLOCK_ALARM,
> + ? ? ? PTP_CLOCK_EXTTS,
> + ? ? ? PTP_CLOCK_PPS,
> +};
> +
> +/**
> + * struct ptp_clock_event - decribes a PTP hardware clock event
> + *
> + * @type: ?One of the ptp_clock_events enumeration values.
> + * @index: Identifies the source of the event.
> + * @timestamp: When the event occured.
> + */
> +
> +struct ptp_clock_event {
> + ? ? ? int type;
> + ? ? ? int index;
> + ? ? ? u64 timestamp;
> +};
> +
> +/**
> + * ptp_clock_event() - notify the PTP layer about an event
> + *
> + * This function should only be called from interrupt context.
> + *
> + * @ptp: ? ?The clock obtained from ptp_clock_register().
> + * @event: ?Message structure describing the event.
> + */
> +
> +extern void ptp_clock_event(struct ptp_clock *ptp,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? struct ptp_clock_event *event);
> +
> +#endif
> --
> 1.6.3.3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
