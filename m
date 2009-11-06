From: schindele@nentec.de (Juergen Schindele)
Date: Fri, 6 Nov 2009 18:42:06 +0200
Subject: [PATCH] Allow platforms to control which PXA uarts are registered
In-Reply-To: <20091105141337.GB21681@n2100.arm.linux.org.uk>
References: <20091105141337.GB21681@n2100.arm.linux.org.uk>
Message-ID: <200911061742.06476.schindele@nentec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell,
this is a good idea because not all PXA based designs use all
of the available uarts. 
I think it would be even better if you could give the order of the
UARTS at the same time in the platform initialisation.

Just like this:
+       pxa_set_btuart_info(0);
+???????pxa_set_ffuart_info(1);
+???????pxa_set_stuart_info(2);
...
+void __init pxa_set_ffuart_info(int id)
+{  
+	pxa_device_ffuart.id = id;
+       pxa_register_device(&pxa_device_ffuart, info);
+}

Which means that the PXA BTUART will be connected to ttyS0,
the PXA FFUART on ttyS1 and so on (in this example of corse).

This would behave the same way as the patch from Bill Gatliff
which was very useful for me some time ago.
http://www.spinics.net/linux/lists/arm-kernel/msg28215.html

Bye
> For some platforms, it is inappropriate to register all PXA UARTs.
> In some cases, the UARTs may not be used, and in others we may want
> to avoid registering the UARTs to allow other drivers (eg, FICP) to
> make use of the UART.
>
> In addition, a while back there was a request to be able to pass
> platform data to the UART driver.

> This patch enables all of this by providing functions platforms can
> call to register each individual UART.
--------------------------------------------------------------
J?rgen Schindele  
Software-Entwicklung

NENTEC Netzwerktechnologie GmbH
Greschbachstr. 12
76229 Karlsruhe
Deutschland
Telefon: +49 721 94249-51
Telefax: +49 721 94249-10
E-Mail:  schindele at nentec.de
WEB:     www.nentec.de
 
Gesch?ftsf?hrung: Klaus Becker, Roland Knapp
Sitz der Gesellschaft: Karlsruhe
Handelsregister: Amtsgericht Mannheim HRB 107658
--------------------------------------------------------------
