From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Jul 2013 11:25:41 +0100
Subject: [PATCH 03/14] ARM: fixup_pv_table bug when CPU_ENDIAN_BE8
In-Reply-To: <20130725101442.GA5609@mudshark.cambridge.arm.com>
References: <1374661682-9349-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374661682-9349-4-git-send-email-ben.dooks@codethink.co.uk>
 <20130724143335.GL11072@mudshark.cambridge.arm.com>
 <51EFF1B2.4050609@codethink.co.uk>
 <20130725101442.GA5609@mudshark.cambridge.arm.com>
Message-ID: <20130725102541.GC24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 11:14:42AM +0100, Will Deacon wrote:
> What's wrong with the following?

Is this like a challenge to find the silly mistake?

> @@ -581,8 +581,13 @@ __fixup_a_pv_table:
>         b       2f
>  1:     add     r7, r3
>         ldrh    ip, [r7, #2]
> +#ifdef CONFIG_CPU_ENDIAN_BE8
> +       and     ip, 0x008f
> +       orr     ip, ip, r6, lsl #24
> +#else
>         and     ip, 0x8f00
>         orr     ip, r6  @ mask in offset bits 31-24
> +#endif
>         strh    ip, [r7, #2]

Well, ip is being loaded/stored as 16bit, but you're putting r6 in to
ip's bits 31-24, which are going to be ignored by the following strh.

The comment "@ mask in offset bits 31-24" refers to the physical address
bits here, which are already pre-shifted to bits 7-0 in r6.
