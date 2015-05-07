From: daniel@iogearbox.net (Daniel Borkmann)
Date: Thu, 07 May 2015 18:18:08 +0200
Subject: [PATCH] ARM: net: delegate filter to kernel interpreter when
 imm_offset() return value can't fit into 12bits.
In-Reply-To: <1431011661-10277-1-git-send-email-nschichan@freebox.fr>
References: <1431011661-10277-1-git-send-email-nschichan@freebox.fr>
Message-ID: <554B9040.50802@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2015 05:14 PM, Nicolas Schichan wrote:
> The ARM JIT code emits "ldr rX, [pc, #offset]" to access the literal
> pool. #offset maximum value is 4095 and if the generated code is too
> large, the #offset value can overflow and not point to the expected
> slot in the literal pool. Additionally, when overflow occurs, bits of
> the overflow can end up changing the destination register of the ldr
> instruction.
>
> Fix that by detecting the overflow in imm_offset() and setting a flag
> that is checked for each BPF instructions converted in
> build_body(). As of now it can only be detected in the second pass. As
> a result the second build_body() call can now fail, so add the
> corresponding cleanup code in that case.
>
> Using multiple literal pools in the JITed code is going to require
> lots of intrusive changes to the JIT code (which would better be done
> as a feature instead of fix), just delegating to the kernel BPF
> interpreter in that case is a more straight forward, minimal fix and
> easy to backport.
>
> Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>

Fix looks good to me.

Fixes: ddecdfcea0ae ("ARM: 7259/3: net: JIT compiler for packet filters")
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
