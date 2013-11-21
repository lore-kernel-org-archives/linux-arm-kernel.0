From: joelf@ti.com (Joel Fernandes)
Date: Thu, 21 Nov 2013 13:48:52 -0600
Subject: [PATCH] ARM: kernel: Detect DTB overwrite and error out
In-Reply-To: <528E397A.2030100@wwwdotorg.org>
References: <1385006644-16024-1-git-send-email-joelf@ti.com>
 <528E397A.2030100@wwwdotorg.org>
Message-ID: <528E63A4.7050708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2013 10:48 AM, Stephen Warren wrote:
> On 11/20/2013 09:04 PM, Joel Fernandes wrote:
>> Kernel can silenty fail for DT-boot after the decompression stage, if DTB is
>> overwritten. Instead of simply failing, we detect the condition and print an
>> error.
>>
>> One may think that it is sufficient for the bootloader to place the DTB away
>> from kernel, but this is not the right fix because: (1) We add more dependence
>> to the bootloader's stupidity (2) the decompressed kernel end address is not
>> known to the loader. Also, we shouldn't depend on bootloader for silently
>> failing us, so we detect the condition and error out.
> 
> If this problem happens, is there any guarantee that the kernel will
> still execute far enough to actually print this error message? Can the

Yes, because till this point we don't depend on DTB yet. We're still just about
to parse it. The problem detected here is the kernel overwriting the DTB, not
the other way.

> decompressor detect this condition instead?

no because:

(1) AIUI, decompressor doesn't have access to vmlinux symbols like _end.
decompressor code is not linked with vmlinux.

(2) The DTB pointer is physical and the _end symbol is virtual so assembly code
has to do the physical to virtual translation before the cmp can be done
which is more messy.

thanks,

-Joel
