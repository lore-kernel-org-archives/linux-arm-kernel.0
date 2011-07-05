From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 05 Jul 2011 22:42:19 +0200
Subject: [PATCH 15/15] pxa2[57]x_udc: drop gpio_pullup handling
In-Reply-To: <1309871321-11305-16-git-send-email-dbaryshkov@gmail.com>
References: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
	<1309871321-11305-16-git-send-email-dbaryshkov@gmail.com>
Message-ID: <4E13772B.2090406@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2011 03:08 PM, Dmitry Eremin-Solenikov wrote:
> Now as all drivers were converted to using gpio-vbus, drop gpio-pullup
> handling from pxa UDC drivers, thus simplifying them a bit.

Is this patch compliant with USB 2 specification regarding maximum time 
between pullup triggering and UDC ready to answer the "RESET" packet and 
be assigned an address ?

This is the sequence I'm worried about :
  (1) The gpio-vbus is loaded
  (2) The pxa27x_udc is loaded
  (3) USB cable is plugged
      => VBUS is sensed
  (4) gpio-vbus pulls up the D+ (Dmitry, is that right ?)
  (5) the host waits for UDC to settle (100 ms ?)
  (5) set address packet(s) are sent from host to UDC
  (6) UDC is not enabled, as no gadget is registered
      => UDC doesn't answer
      => usb host cannot assign it an address
  (7) a gadget is loaded (g_ether for example)
      => UDC is enabled, but too late

Alan, Gregh, could you confirm point (5) about a maximum time between D+ 
line activation and UDC duty to repond to "set address" packets, as well 
as the consequence of point (6) where the usb device is rejected because 
no address could be assigned ?

Dmitry, could you confirm the the D+ pullup is done at point (4) ?

Cheers.

--
Robert
