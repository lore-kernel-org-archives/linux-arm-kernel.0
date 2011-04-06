From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Wed, 6 Apr 2011 23:12:44 +0200
Subject: [RFC][PATCH] bcmai: introduce AI driver
In-Reply-To: <1302124112.20093.11.camel@maggie>
References: <1302033463-1846-1-git-send-email-zajec5@gmail.com>
	<op.vtisojsk3ri7v4@arend-laptop>
	<BANLkTinubrmryu=Bco5_AVcj_arn7SWZxw@mail.gmail.com>
	<op.vti9ote53ri7v4@arend-laptop>
	<BANLkTin-u=U_-cUH9oCco0LjEBuQmh4wag@mail.gmail.com>
	<BANLkTi=x89+52cMeutOB7J--QQta+mX_wg@mail.gmail.com>
	<1302123428.20093.6.camel@maggie>
	<BANLkTimGSoYzp0Z4vyCS_H5PDKhgjYuLBA@mail.gmail.com>
	<1302124112.20093.11.camel@maggie>
Message-ID: <BANLkTik76dwwnmmPzXL9Kkk7fdt01QPzZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 6 kwietnia 2011 23:08 u?ytkownik Michael B?sch <mb@bu3sch.de> napisa?:
> On Wed, 2011-04-06 at 23:01 +0200, Rafa? Mi?ecki wrote:
>> W dniu 6 kwietnia 2011 22:57 u?ytkownik Michael B?sch <mb@bu3sch.de> napisa?:
>> > On Wed, 2011-04-06 at 22:42 +0200, Rafa? Mi?ecki wrote:
>> >> 2011/4/6 Rafa? Mi?ecki <zajec5@gmail.com>:
>> >> > If we want to have two drivers working on two (different) cores
>> >> > simultaneously, we will have to add trivial mutex to group core
>> >> > switching with core operation (read/write).
>> >>
>> >> With a little of work we could avoid switching and mutexes on no-host
>> >> boards. MMIO is not limited to one core at once in such a case.
>> >
>> > I don't think that this is a problem at all.
>> > All that magic does happen inside of the bus I/O handlers.
>> > Just like SSB does it.
>> > From a driver point of view, the I/O functions just need to
>> > be atomic.
>> >
>> > For SSB it's not always 100% atomic, but we're always safe
>> > due to some assumptions being made. But this is an SSB implementation
>> > detail that is different from AXI. So don't look too closely
>> > at the SSB implementation of the I/O functions. You certainly want
>> > to implement them slightly differently in AXI. SSB currently doesn't
>> > make use of the additional sliding windows, because they are not
>> > available in the majority of SSB devices.
>> >
>> > The AXI bus subsystem will manage the sliding windows and the driver
>> > doesn't know about the details.
>>
>> Sure, I've meant mutex inside bcmai (or whatever name), not on the driver side!
>>
>> In BCMAI:
>> bcmai_read() {
>> mutex_get();
>> switch_core();
>> ioread();
>> mutex_release();
>> }
>
> Yeah that basically is the idea. But it's a little bit harder than that.
> The problem is that the mutex cannot be taken in interrupt context.
> A spinlock probably is a bit hairy, too, depending on how heavy
> a core switch is on AXI.
>
> On SSB we workaround this with some (dirty but working) assumptions.
>
> On AXI you probably can do lockless I/O, if you use the two windows
> (how many windows are there?) in a clever way to avoid core switching
> completely after the system was initialized.

We have 2 windows. I didn't try this, but let's assume they have no
limitations. We can use first window for one driver only, second
driver for second driver only. That gives us 2 drivers simultaneously
working drivers. No driver need to reset core really often (and not
inside interrupt context) so we will switch driver's window to agent
(from core) only at init/reset.

The question is what amount of driver we will need to support at the same time.

-- 
Rafa?
