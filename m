From: jays.lee@samsung.com (Jungseok Lee)
Date: Wed, 07 May 2014 12:10:37 +0900
Subject: [PATH V3] arm64: mm: Create gigabyte kernel logical mappings where
 possible
In-Reply-To: <1399381347-28676-1-git-send-email-steve.capper@linaro.org>
References: <1399381347-28676-1-git-send-email-steve.capper@linaro.org>
Message-ID: <001901cf69a1$eb1fe1a0$c15fa4e0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 06, 2014 10:02 PM, Steve Capper wrote:
> We have the capability to map 1GB level 1 blocks when using a 4K
> granule.
> 
> This patch adjusts the create_mapping logic s.t. when mapping physical
> memory on boot, we attempt to use a 1GB block if both the VA and PA
> start and end are 1GB aligned. This both reduces the levels of lookup
> required to resolve a kernel logical address, as well as reduces TLB
> pressure on cores that support 1GB TLB entries.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

I've tried it on top of 3.15-rc4 with A57 Fastmodel. It works well.

Tested-by: Jungseok Lee <jays.lee@samsung.com>

> ---
> Changed in V3: added awareness of 1GB blocks to kern_addr_valid.
> This was tested via gdb:
> gdb ./vmlinux /proc/kcore
> disassemble kern_addr_valid
> 
> The output looked valid.
> In V2 of the patch, I got an oops.
> 
> I've defined constants with pgdval_t type. Ideally, I would like to
> define pudval_t types, but due to the way folding works this does not
> exist for <4 levels. I'm not sure if it would be better to define
> pudval_t for <4 levels or leave this as is?

I got the same question when I wrote 4 level patches.
Although my choice was pgdval_t, I still cannot tell which one
is better.

- Jungseok Lee
