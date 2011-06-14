From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Jun 2011 07:53:29 -0700
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <alpine.LFD.2.00.1106140300500.2142@xanadu.home>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<20110612081541.GA10283@n2100.arm.linux.org.uk>
	<20110612083414.GA29516@S2100-06.ap.freescale.net>
	<20110612092131.GC10283@n2100.arm.linux.org.uk>
	<20110612095217.GD10283@n2100.arm.linux.org.uk>
	<20110612104215.GC29516@S2100-06.ap.freescale.net>
	<20110612104048.GE10283@n2100.arm.linux.org.uk>
	<8yaaadlfi3q.fsf@huya.qualcomm.com>
	<alpine.LFD.2.00.1106131910570.2142@xanadu.home>
	<alpine.LFD.2.00.1106140300500.2142@xanadu.home>
Message-ID: <20110614145329.GK23145@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nicolas.pitre@linaro.org> [110614 00:04]:
> +
> +	for_each_tag(atag, atag_list) {
> +		if (atag->hdr.tag == ATAG_CMDLINE) {
> +			setprop_string(dt, "/chosen", "bootargs",
> +			                  atag->u.cmdline.cmdline);
> +		} else if (atag->hdr.tag == ATAG_MEM) {
> +			uint32_t mem_reg_property[2];
> +			mem_reg_property[0] = cpu_to_fdt32(atag->u.mem.start);
> +			mem_reg_property[1] = cpu_to_fdt32(atag->u.mem.size);
> +			setprop(dt, "/memory", "reg", mem_reg_property,
> +			           sizeof(mem_reg_property));
> +		} else if (atag->hdr.tag == ATAG_INITRD2) {
> +			uint32_t initrd_start, initrd_size;
> +			initrd_start = atag->u.initrd.start;
> +			initrd_size = atag->u.initrd.size;
> +			setprop_cell(dt, "/chosen", "linux,initrd-start",
> +			                initrd_start);
> +			setprop_cell(dt, "/chosen", "linux,initrd-end",
> +			                initrd_start + initrd_size);
> +		}
> +	}

I think Russell posted a complete list of the ATAGs to translate
somewhere, but at least ATAG_REVISION is missing here. That's being
used quite a bit as system_rev to set things dynamically.

Regards,

Tony
