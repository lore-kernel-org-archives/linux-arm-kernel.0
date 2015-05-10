From: davem@davemloft.net (David Miller)
Date: Sun, 10 May 2015 19:22:17 -0400 (EDT)
Subject: [PATCH] ARM: net: delegate filter to kernel interpreter when
 imm_offset() return value can't fit into 12bits.
In-Reply-To: <1431011661-10277-1-git-send-email-nschichan@freebox.fr>
References: <1431011661-10277-1-git-send-email-nschichan@freebox.fr>
Message-ID: <20150510.192217.1306037281172187835.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Schichan <nschichan@freebox.fr>
Date: Thu,  7 May 2015 17:14:21 +0200

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

Applied, thanks Nicolas.
