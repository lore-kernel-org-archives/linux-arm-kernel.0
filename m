From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Thu, 21 Oct 2010 22:28:49 +0200
Subject: [PATCH 1/2] mmc: quirk fix for timeout problem
In-Reply-To: <AANLkTikokkVaAjA+b6f56Syv0h8odiN4koJTOaFW_Ebx@mail.gmail.com>
References: <1287564807-1645-1-git-send-email-shawn.gsc@gmail.com>	<1287566576-1224-1-git-send-email-shawn.gsc@gmail.com>	<20101020112741.GB10261@pengutronix.de>	<AANLkTinairUcKpTH2ePjbp3j7qdsmrPCeeWR_E+RSsPU@mail.gmail.com>	<alpine.LFD.2.00.1010211308340.2764@xanadu.home>
	<AANLkTikokkVaAjA+b6f56Syv0h8odiN4koJTOaFW_Ebx@mail.gmail.com>
Message-ID: <4CC0A281.1010202@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

test protocol : booting a 2.6.36-rc8 kernel with a rootfs (ext3 formated, 
generated with OpenEmbedded for armv5, loading and launching qtdemo 4.6.3) on 
a 8GB ?SDHC  (uSD reformated after each board tests to trigger lot of 
read/writes on the first init).

* on an i.MX357 (rev 2.1) without this patch leads to :
mmcblk0: error -110 transferring data, sector 7347024, nr 8, card status 0xe00
end_request: I/O error, dev mmcblk0, sector 7347025

Same card, same board, with the timeout quirk patch : boots fine without any 
error.

Reverted the patch: timeout errors came back.

==> quirk timeout patch needed for the i.MX35

* on an i.MX257 (tested twice) :
Same kernel tree, same rootfs, same motherboard, same uSD, only the CPU module 
change : no error without the patch (and no error with the patch also ;-).

==> quirk timeout patch not needed for the i.MX25

* on an i.MX515 :
Same kernel tree, same rootfs, same motherboard, same uSD (re-formated), only 
the CPU module change without this patch leads to :
mmcblk0: error -84 transferring data, sector 1315598, nr 2, card status 0x900
end_request: I/O error, dev mmcblk0, sector 1315598

Same card, same board, with the timeout quirk patch : boots fine without any 
error.

Reverted the patch: timeout errors came back.

==> quirk timeout patch needed for the i.MX51

Updated patch follows.

Eric
