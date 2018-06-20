From: javierm@redhat.com (Javier Martinez Canillas)
Date: Wed, 20 Jun 2018 11:04:38 +0200
Subject: [PATCH] driver core: add a debugfs entry to show deferred devices
In-Reply-To: <CAHp75VcOd5K+T6bkxyz3qgqNr4-=K9GGRh+DQ_qgW7dGKdzO5A@mail.gmail.com>
References: <20180619205914.21375-1-javierm@redhat.com>
 <20180619225145.GA23389@kroah.com>
 <CAHp75VcOd5K+T6bkxyz3qgqNr4-=K9GGRh+DQ_qgW7dGKdzO5A@mail.gmail.com>
Message-ID: <c5ff2e6a-6bbf-deea-5250-7588b8046750@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On 06/20/2018 01:43 AM, Andy Shevchenko wrote:
> On Wed, Jun 20, 2018 at 1:51 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Tue, Jun 19, 2018 at 10:59:14PM +0200, Javier Martinez Canillas wrote:
>>> For debugging purposes it may be useful to know what are the devices whose
>>> probe function was deferred. Add a debugfs entry showing that information.
>>>
>>>   $ cat /sys/kernel/debug/deferred_devices
>>>   48070000.i2c:twl at 48:bci
>>>   musb-hdrc.0.auto
>>>   omapdrm.0
> 
> 
>> And what is the use of this file?  What can you do with this
>> information?  Who is going to use it?  Don't we have other deferred
>> probe debugging somewhere else?
> 
> Indeed.
> 
> Javier, have you tried to add 'initcall_debug' to a kernel command
> line followed by 'dyndbg="file drivers/base/dd.c +p"'?
> 

I already mentioned this to Greg, but I'll elaborate a little bit. Using these
kernel cmdline options will only tell us when a driver for a device was probed
or deferred but it doesn't tell us what's left in the queue after all drivers
have been registered.

Yes, we could parse the kernel log and do some computation to figure out if a
deferred driver finally got probed, but I don't understand why we can't just
expose the deferred queue if the kernel already has that info and is useful?

But even if we do that, the current debug printouts are only enabled until
late_initcall time. So it won't print deferred probes for drivers registered
by modules:

static void deferred_probe_work_func(struct work_struct *work)
{
...
	if (initcall_debug && !initcalls_done)
		deferred_probe_debug(dev);
	else
		bus_probe_device(dev);
...
}

static int deferred_probe_initcall(void)
{
...
	initcalls_done = true;
...
}
late_initcall(deferred_probe_initcall);

Again, we could change that but in my opinion we should try to make debug more
easier and this patch is quite trivial. The kernelci folks said that this will
be useful for them and allows to detect regressions on drivers' probe as early
as possible, which I think is very important.

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
