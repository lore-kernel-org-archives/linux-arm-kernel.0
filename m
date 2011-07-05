From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 6 Jul 2011 00:58:48 +0400
Subject: [PATCH 15/15] pxa2[57]x_udc: drop gpio_pullup handling
In-Reply-To: <4E13772B.2090406@free.fr>
References: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
	<1309871321-11305-16-git-send-email-dbaryshkov@gmail.com>
	<4E13772B.2090406@free.fr>
Message-ID: <CALT56yP5yNPZoJ_+6a4t2t6rY_hmej5fc-NG02Jef-QiXHrc=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/6/11, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> On 07/05/2011 03:08 PM, Dmitry Eremin-Solenikov wrote:
>> Now as all drivers were converted to using gpio-vbus, drop gpio-pullup
>> handling from pxa UDC drivers, thus simplifying them a bit.
>
> Is this patch compliant with USB 2 specification regarding maximum time
> between pullup triggering and UDC ready to answer the "RESET" packet and
> be assigned an address ?
>
> This is the sequence I'm worried about :
>   (1) The gpio-vbus is loaded
>   (2) The pxa27x_udc is loaded
>   (3) USB cable is plugged
>       => VBUS is sensed
>   (4) gpio-vbus pulls up the D+ (Dmitry, is that right ?)
>   (5) the host waits for UDC to settle (100 ms ?)
>   (5) set address packet(s) are sent from host to UDC
>   (6) UDC is not enabled, as no gadget is registered
>       => UDC doesn't answer
>       => usb host cannot assign it an address
>   (7) a gadget is loaded (g_ether for example)
>       => UDC is enabled, but too late
>
> Alan, Gregh, could you confirm point (5) about a maximum time between D+
> line activation and UDC duty to repond to "set address" packets, as well
> as the consequence of point (6) where the usb device is rejected because
> no address could be assigned ?
>
> Dmitry, could you confirm the the D+ pullup is done at point (4) ?

No, I can't confirm this. IIUC, evrything happens in abit different way:
(4) trancseiver notifies udc about VBUS sense
(5) a gadget is loaded (g_ether for example)
(6) gadget asks udc to enale  pullup
(7) udc tells gpio_vbus to enable pullup.

etc...

>
> Cheers.
>
> --
> Robert
>


-- 
With best wishes
Dmitry
