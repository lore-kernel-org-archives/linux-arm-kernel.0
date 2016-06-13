From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 13 Jun 2016 16:31:34 +0200
Subject: [PATCH v2 0/4] ARM: dts: r8a7790: lager: use demuxer for I2C
In-Reply-To: <1465370066-8450-1-git-send-email-horms+renesas@verge.net.au>
References: <1465370066-8450-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20160613143134.GB1603@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>    # ./exercise-i2c-demux.sh
>    I2C Demux: i2c-8
>      Master: 1:/i2c at e650800
>    [   97.694487] i2c-rcar e6508000.i2c: probed 0 (1)
>      Master: 0:/i2c at e650000
>    [  102.706365] i2c-demux-pinctrl i2c-8: failed to setup demux-adapter 0 (-19) 0 (0)

Confirmed :( Got today only this far that the ENODEV comes from the PFC
driver. CONFIG_DEBUG_PINCTRL is a good idea for further debugging
probably.

>    3.1 Unfortunately it fails for the I2C2 dmux if the GPIO fallback is
>        present.

Hopefully the same issue.

>    3.2 The test also fails for the I2C3 demux but that appears to be due
>        to a shortcoming in the voltage regulator code which does not
>        appear to like being reinitialised. The kernel complains as follows:

Yes, the demuxer trigger re-bind cycles which are not well considered
and/or tested. E.g. for soc-camera, this patch needed to go upstream:

https://patchwork.linuxtv.org/patch/32473/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160613/096f1ecb/attachment.sig>
