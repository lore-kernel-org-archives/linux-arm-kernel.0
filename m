From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 09 Jan 2015 19:18:49 +0000
Subject: [PATCH v20 08/11] ARM: kprobes: enable OPTPROBES for ARM 32
In-Reply-To: <20150109175711.GA12302@n2100.arm.linux.org.uk>
References: <1420457376-77366-1-git-send-email-wangnan0@huawei.com>
 <1420785456-21900-1-git-send-email-wangnan0@huawei.com>
 <1420799154.4160.19.camel@linaro.org>
 <20150109163505.GS12302@n2100.arm.linux.org.uk>
 <1420824502.4160.62.camel@linaro.org>
 <20150109175711.GA12302@n2100.arm.linux.org.uk>
Message-ID: <1420831129.4160.78.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-01-09 at 17:57 +0000, Russell King - ARM Linux wrote:
[...]
> For me:
> 
> $ echo 'asm ("bx r2\n");' | arm-linux-gcc -x c -c -marm -march=armv4 -v - -o o.o
> 
> calls the assembler thusly:
> 
> /usr/local/lib/gcc/arm-linux-gnueabi/4.7.4/../../../../arm-linux-gnueabi/bin/as \
> -v -march=armv4 -meabi=5 --fix-v4bx -o o.o /tmp/ccB0cZgO.s
> 
> Sure enough, the object file contains:
> 
> 00000000 <.text>:
>    0:   e12fff12        bx      r2
>                         0: R_ARM_V4BX   *ABS*
> 
> so it looks like it's been told...  Then if you do:
> 
> $ arm-linux-ld --fix-v4bx -o o1.o o.o
> $ arm-linux-objdump -dr o1.o
> 
> you get:
> 
>     8074:       e1a0f002        mov     pc, r2

I get results consistent with what you get above. A bit of googling
seems to indicate the generate-BX-and-fix-it-in-the-linker came in many
years ago with AEABI support.

> Hmm, I wonder if this means we should have the kernel linker deal with
> V4BX relocations on ARMv4, converting them to their mov pc, X variant.
> 
> Also, do we need --fix-v4bx for the link of vmlinux?

I guess the answer is yes if we want to catch uses of BX in inline
assembly. A quick and not very thorough grep of arch/arm for 'bx'
doesn't seem to turn up any existing dodgy uses, except in the kprobes
test code I wrote :-(

-- 
Tixy
