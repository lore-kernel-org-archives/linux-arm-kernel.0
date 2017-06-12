From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Jun 2017 12:06:11 +0100
Subject: [PATCH v2] arm: eBPF JIT compiler
In-Reply-To: <593E6B0F.8070901@iogearbox.net>
References: <1495754003-21099-1-git-send-email-illusionist.neo@gmail.com>
 <CAGXu5jKmLNMR+uhM9Ov2XPW6kCjip_SjScgEH0fTFp6fQtKFiA@mail.gmail.com>
 <593E6B0F.8070901@iogearbox.net>
Message-ID: <20170612110611.GC4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 12:21:03PM +0200, Daniel Borkmann wrote:
> On 05/30/2017 09:19 PM, Kees Cook wrote:
> >On Thu, May 25, 2017 at 4:13 PM, Shubham Bansal
> ><illusionist.neo@gmail.com> wrote:
> >>+static int validate_code(struct jit_ctx *ctx)
> >>+{
> >>+       int i;
> >>+
> >>+       for (i = 0; i < ctx->idx; i++) {
> >>+               u32 a32_insn = le32_to_cpu(ctx->target[i]);
> 
> Given __opcode_to_mem_arm(ARM_INST_UDF) is used to fill the image,
> perhaps use the __mem_to_opcode_arm() helper for the check?
> 
> >>+               if (a32_insn == ARM_INST_UDF)

The following is probably better:

		if (ctx->target[i] == __opcode_to_mem_arm(ARM_INST_UDF))

since then you can take advantage of the compiler optimising the
constant rather than having to do a byte swap on an unknown 32-bit
value.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
