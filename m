From: saeed.bishara@gmail.com (saeed bishara)
Date: Sun, 2 May 2010 18:21:52 +0300
Subject: [PATCH 3/5] USB: add clk structure for systems that support
	clkdev framework
In-Reply-To: <20100502151425.GC4233@n2100.arm.linux.org.uk>
References: <1272810162-14858-1-git-send-email-saeed@marvell.com>
	<1272810162-14858-2-git-send-email-saeed@marvell.com>
	<1272810162-14858-3-git-send-email-saeed@marvell.com>
	<1272810162-14858-4-git-send-email-saeed@marvell.com>
	<20100502143602.GA4233@n2100.arm.linux.org.uk>
	<r2oc70ff3ad1005020805zc80ad8b9n1e56d4a0a6ce5b9c@mail.gmail.com>
	<20100502151425.GC4233@n2100.arm.linux.org.uk>
Message-ID: <u2wc70ff3ad1005020821z5eb3eec5y5a64b1d5dd3652a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 2, 2010 at 6:14 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, May 02, 2010 at 06:05:32PM +0300, saeed bishara wrote:
>> On Sun, May 2, 2010 at 5:36 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Sun, May 02, 2010 at 05:22:40PM +0300, Saeed Bishara wrote:
>> >> @@ -110,6 +111,9 @@ struct usb_hcd {
>> >> ? ? ? u64 ? ? ? ? ? ? ? ? ? ? rsrc_start; ? ? /* memory/io resource start */
>> >> ? ? ? u64 ? ? ? ? ? ? ? ? ? ? rsrc_len; ? ? ? /* memory/io resource length */
>> >> ? ? ? unsigned ? ? ? ? ? ? ? ?power_budget; ? /* in mA, 0 = no limit */
>> >> +#if defined(CONFIG_HAVE_CLK)
>> >> + ? ? struct clk ? ? ? ? ? ? ?*clk;
>> >> +#endif
>> >
>> > We have other hci's using the clk API, why do we need to add this for
>> > them too? ?In other words, why can't the orion HCI driver work like
>> > the other HCI drivers such as ohci-pxa27x.c or ehci-omap.c ?
>> >
>> if most of those drivers need clk structure then why not to add it to
>> the usb_hcd which hold the common stuff?
>
> drivers/usb/host/ohci-s3c2410.c: ? ? ? ?2
> drivers/usb/host/ohci-omap.c: ? ? ? ? ? 2
> drivers/usb/host/r8a66597-hcd.c: ? ? ? ?1
> drivers/usb/host/ehci-mxc.c: ? ? ? ? ? ?2
> drivers/usb/host/ohci-da8xx.c: ? ? ? ? ?2
> drivers/usb/host/ohci-pxa27x.c: ? ? ? ? 1
> drivers/usb/host/ohci-pnx4008.c: ? ? ? ?1
> drivers/usb/host/imx21-hcd.c: ? ? ? ? ? 1
> drivers/usb/host/ohci-ep93xx.c: ? ? ? ? 1
> drivers/usb/host/ehci-atmel.c: ? ? ? ? ?2
> drivers/usb/host/ehci-omap.c: ? ? ? ? ? 5
> drivers/usb/host/ohci-at91.c: ? ? ? ? ? 2
>
> So, five drivers need one clock, six drivers need two clocks, and one
> driver needs five clocks. ?So maybe you should be catering for the
> common case by providing two struct clk's, or maybe catering for the
> maximal case of five clocks?
well, I think that those drivers that have more than one clk can be
redesigned by adding virtual clk for the the usb host, and the clk
implementation for that soc should manage all the underlying physical
clocks. I've looked at the omap,at91 and atmel, and it looks to me
that this is doable. you see can see that the clk stuff in those
driver has nothing to do with usb itself. what do you think?

>
> Having these patches with this patch submission may actually help your
> case by showing the benefits of such a cleanup - eg, if it eliminates
> private driver data structures entirely, it's definitely worth it.
your right, I have had to send kind of RFC for this issue.
>
