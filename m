From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 31 May 2016 11:39:00 -0600
Subject: [PATCH 1/5] coresight: Fix NULL pointer dereference in
 _coresight_build_path
In-Reply-To: <1464695858-29284-2-git-send-email-suzuki.poulose@arm.com>
References: <1464695858-29284-1-git-send-email-suzuki.poulose@arm.com>
 <1464695858-29284-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <CANLsYkwgdSF9CA+fZFg_SFN2xg4LW7eqZ0=-v8yaM4wdgwMPjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 May 2016 at 05:57, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> _coresight_build_path assumes that all the connections of a csdev
> has the child_dev initialised. This may not be true if the particular
> component is not supported by the kernel config(e.g TPIU) but is
> present in the DT. In which case, building a path can cause a crash like this :
>
>   Unable to handle kernel NULL pointer dereference at virtual address 00000010
>   pgd = ffffffc9750dd000
>   [00000010] *pgd=00000009f5e90003, *pud=00000009f5e90003, *pmd=0000000000000000
>   Internal error: Oops: 96000006 [#1] PREEMPT SMP
>   Modules linked in:
>   CPU: 4 PID: 1348 Comm: bash Not tainted 4.6.0-next-20160517 #1646
>   Hardware name: ARM Juno development board (r0) (DT)
>   task: ffffffc97517a280 ti: ffffffc9762c4000 task.ti: ffffffc9762c4000
>   PC is at _coresight_build_path+0x18/0xe4
>   LR is at _coresight_build_path+0xc0/0xe4
>   pc : [<ffffff80083d5130>] lr : [<ffffff80083d51d8>] pstate: 20000145
>   sp : ffffffc9762c7ba0
>
>   [<ffffff80083d5130>] _coresight_build_path+0x18/0xe4
>   [<ffffff80083d51d8>] _coresight_build_path+0xc0/0xe4
>   [<ffffff80083d51d8>] _coresight_build_path+0xc0/0xe4
>   [<ffffff80083d51d8>] _coresight_build_path+0xc0/0xe4
>   [<ffffff80083d51d8>] _coresight_build_path+0xc0/0xe4
>   [<ffffff80083d51d8>] _coresight_build_path+0xc0/0xe4
>   [<ffffff80083d5cdc>] coresight_build_path+0x40/0x68
>   [<ffffff80083d5e14>] coresight_enable+0x74/0x1bc
>   [<ffffff80083d60a0>] enable_source_store+0x3c/0x6c
>   [<ffffff800830b17c>] dev_attr_store+0x18/0x28
>   [<ffffff80081ca9c4>] sysfs_kf_write+0x40/0x50
>   [<ffffff80081c9e38>] kernfs_fop_write+0x140/0x1cc
>   [<ffffff8008163ec8>] __vfs_write+0x28/0x110
>   [<ffffff8008164bf0>] vfs_write+0xa0/0x174
>   [<ffffff8008165d18>] SyS_write+0x44/0xa0
>   [<ffffff8008084e70>] el0_svc_naked+0x24/0x28
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 5443d03..0fdaaf4 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -385,7 +385,6 @@ static int _coresight_build_path(struct coresight_device *csdev,
>         int i;
>         bool found = false;
>         struct coresight_node *node;
> -       struct coresight_connection *conn;
>
>         /* An activated sink has been found.  Enqueue the element */
>         if ((csdev->type == CORESIGHT_DEV_TYPE_SINK ||
> @@ -394,8 +393,9 @@ static int _coresight_build_path(struct coresight_device *csdev,
>
>         /* Not a sink - recursively explore each port found on this element */
>         for (i = 0; i < csdev->nr_outport; i++) {
> -               conn = &csdev->conns[i];
> -               if (_coresight_build_path(conn->child_dev, path) == 0) {
> +               struct coresight_device *child_dev = csdev->conns[i].child_dev;
> +
> +               if (child_dev && _coresight_build_path(child_dev, path) == 0) {
>                         found = true;
>                         break;
>                 }
> --
> 1.9.1
>

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Greg, since this is a bug fix can we add it to 4.7-rc2?

Thanks,
Mathieu
