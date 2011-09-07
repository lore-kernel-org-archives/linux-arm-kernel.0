From: govindraj.raja@ti.com (Govindraj.R)
Date: Wed, 7 Sep 2011 18:23:22 +0530
Subject: [PATCH v4 00/11] OMAP2+: Serial: Runtime adaptation + cleanup
Message-ID: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Converting uart driver to adapt to pm runtime API's.
Code re-org + cleanup.
Moving some functionality from serial.c to omap-serial.c

Changes involves:
================
1.) Cleaning up certain uart calls from sram_idle func.
2.) Removed all types of uart clock handling code from serial.c
3.) Using hwmod_mux API enable wakeup capability for uart pad during
   hwmod_idle state i.e., when uart clocks are disabled we can enable
   io-pad wakeup capability for uart if mux_data is available for
   given uart. Also during during resume from idle call to uart we need
   to enable clocks back conditionally and this can be done only when io-pad
   wakeup event bit is set for uart_rx pad. So we need a hwmod API
   which can probe the uart pad and let us know whether a uart wakeup
   happened. So omap_hmwod_pad_wakeup_status API is added to meet this
   requirement.
3.) Adapted omap-serial driver to use runtime API's.
4.) Modify serial_init calls to accept certain uart parameters from board file.
5.) using prepare and resume_call to disable/enable uart_port.
    Reference to discussion why we need to use prepare and resume hooks.
	http://www.mail-archive.com/linux-omap at vger.kernel.org/msg52707.html
	http://www.mail-archive.com/linux-omap at vger.kernel.org/msg53209.html
	
Patch series is based on 3.1.0-rc4 + omap_device fixes.
