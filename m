From: linuxzsc@gmail.com (Richard Zhao)
Date: Fri, 23 Oct 2009 19:27:08 +0800
Subject: [PATCH] imx/gpio: Use handle_level_irq
In-Reply-To: <20091020173737.GA6819@pengutronix.de>
References: <1255983568-20958-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091020081303.GO8818@pengutronix.de>
	<20091020173737.GA6819@pengutronix.de>
Message-ID: <4e090d470910230427t3fb2d20rce3c25b3be392944@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/10/21 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Sascha,
>
> On Tue, Oct 20, 2009 at 10:13:03AM +0200, Sascha Hauer wrote:
>> On Mon, Oct 19, 2009 at 10:19:28PM +0200, Uwe Kleine-K?nig wrote:
>> > According to Russell King handle_edge_irq is only useful for "edge-based
>> > inputs where the controller does not remember transitions with the input
>> > masked."
>> >
>> > So using handle_edge_irq unconditionally for both edge and level irqs is
>> > wrong. ?Testing showed that the controller does remember transitions
>> > while the interrupt is masked. ?So use handle_level_irq unconditionally.
>>
>> As this fixes only rt kernels and we have no reports that something is
>> not working on non rt kernels I suggest putting this into the next merge
>> window.
> The PMIC on pcm038 doesn't work anymore with handle_edge_irq since I
> switched to using threaded irqs in the driver. ?But as this won't hit
> mainline before the next merge window that is fine for me, too.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Uwe Kleine-K?nig ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? ? ?| http://www.pengutronix.de/ ?|
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

handle_level_irq may lost edge irq request. The controller won't
change ISR when irq's masked.
Why not decide to use handle_level_irq or handle_edge_irq in gpio_set_irq_type?

Thanks
Richard
