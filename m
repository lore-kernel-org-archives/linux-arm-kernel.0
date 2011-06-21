From: davidb@codeaurora.org (David Brown)
Date: Tue, 21 Jun 2011 10:32:19 -0700
Subject: [PATCH 4/4] ARM: zImage: allow supplementing appended DTB with
	traditional ATAG data
In-Reply-To: <20110621070058.GA9228@S2101-09.ap.freescale.net> (Shawn Guo's
	message of "Tue, 21 Jun 2011 15:00:59 +0800")
References: <1308632955-11070-1-git-send-email-nico@fluxnic.net>
	<1308632955-11070-5-git-send-email-nico@fluxnic.net>
	<20110621070058.GA9228@S2101-09.ap.freescale.net>
Message-ID: <8yad3i7nl98.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21 2011, Shawn Guo wrote:

> On Tue, Jun 21, 2011 at 01:09:15AM -0400, Nicolas Pitre wrote:
>> From: Nicolas Pitre <nicolas.pitre@linaro.org>
>> 
>> Some old bootloaders can't be updated to a device tree capable one,
>> yet they provide ATAGs with memory configuration, the ramdisk address,
>> the kernel cmdline string, etc.  To allow a device tree enabled
>> kernel to be used with such bootloaders, it is necessary to convert those
>> ATAGs into FDT properties and fold them into the DTB appended to zImage.
>> 
>> Currently the following ATAGs are converted:
>> 
>> 	ATAG_CMDLINE
>> 	ATAG_MEM (up to 8 memory regions)
>> 	ATAG_INITRD2
>> 
>> If the corresponding information already exists in the appended DTB, it
>> is replaced, otherwise the required node is created to hold it.
>> 
>> The code looks for ATAGs at the location pointed by the value of r2 upon
>> entry into the zImage code.  If no ATAGs are found there, an attempt at
>> finding ATAGs at the typical 0x100 offset from start of RAM is made.
>> Otherwise the DTB is left unchanged.
>> 
>> Thisstarted from an older patch from John Bonesio <bones@secretlab.ca>,
>> with contributions from David Brown <davidb@codeaurora.org>.
>> 
>> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
>> ---
>
> With this patch applied, I saw nothing coming from kernel on imx51
> babbage serial port.

Can you try seeing if it works with padding in the DTB that you are
using?  Right now, I'm using something like:

/ {
	...
	memory {
		reg = <0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>;
	};
	chosen {
		bootargs = "                              "; /* Enough for arg */
		linux,initrd-start = <0>;
		linux,initrd-end = <0>;
	};
};

I get problems if the fdt code tries to expand the tree, even if I add
padding when running the dtc (I've tried -p 1024).

Hopefully, I'll get some time today to try and figure out what is going
on.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
