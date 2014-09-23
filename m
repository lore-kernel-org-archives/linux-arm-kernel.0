From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Sep 2014 15:40:02 +0100
Subject: [PATCH] arm64: debug: don't re-enable debug exceptions on return
 from el1_dbg
In-Reply-To: <1411381144-3528-1-git-send-email-will.deacon@arm.com>
References: <1411381144-3528-1-git-send-email-will.deacon@arm.com>
Message-ID: <20140923144001.GB6858@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 11:19:04AM +0100, Will Deacon wrote:
> When returning from a debug exception taken from EL1, we unmask debug
> exceptions after handling the exception. This is crucial for debug
> exceptions taken from EL0, so that any kernel work on the ret_to_user
> path can be debugged by kgdb.
> 
> However, when returning back to EL1 the only thing left to do is to
> restore the original register state before the exception return. If
> single-step has been enabled by the debug exception handler, we will
> get stuck in an infinite debug exception loop, since we will take the
> step exception as soon as we unmask debug exceptions.
> 
> This patch avoids unmasking debug exceptions on the debug exception
> return path when the exception was taken from EL1.
> 
> Cc: <stable@vger.kernel.org>

Does it work better if I add:

Fixes: 2a2830703a23 (arm64: debug: avoid accessing mdscr_el1 on fault paths where possible)
Cc: <stable@vger.kernel.org> #3.16+

-- 
Catalin
