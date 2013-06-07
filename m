From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Fri, 7 Jun 2013 01:48:46 +0000
Subject: [PATCH v6] tty: serial: add Freescale lpuart driver support
In-Reply-To: <CAOMZO5D+NLMc=10=iF6bd=3aav9ePZBQEJY7WKJpkp+fA=Cp1w@mail.gmail.com>
References: <1370309270-21019-1-git-send-email-b35083@freescale.com>
 <20130606200519.GA1644@kroah.com>
 <CAOMZO5D+NLMc=10=iF6bd=3aav9ePZBQEJY7WKJpkp+fA=Cp1w@mail.gmail.com>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851CFC25@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> This breaks the build on x86 systems with:
>>   CC [M]  drivers/tty/serial/fsl_lpuart.o
>> drivers/tty/serial/fsl_lpuart.c: In function ?lpuart_probe?:
>> drivers/tty/serial/fsl_lpuart.c:751:2: error: implicit declaration of
>> function ?of_alias_get_id? [-Werror=implicit-function-declaration]
>>
>> so I can't take this :(
>
>On imx serial driver this build error is avoided by protecting the
>serial_imx_probe_dt() with "#ifdef CONFIG_OF" and you could so the same on
>the fsl_lpaurt driver to avoid the build issue that Greg reported.

[Lu Jingchang-B35083] 
  imx serial driver supports dt and non-dt uart device, "#ifdef CONFIG_OF" seems
to distinguish these, but fsl_lpuart only support dt device. 
  of_alias_get_id is defined in <linux/of.h>, it's referenced by <linux/of_device.h>
but with "#ifdef CONFIG_OF_DEVICE" restriction. So indirectly referencing "of.h" by
"of_device.h" without CONFIG_OF_DEVICE option will cause build error. Add direct
reference to "<linux/of.h>" in driver can resolve this error.
Thanks!
