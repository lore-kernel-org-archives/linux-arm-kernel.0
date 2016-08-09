From: pmladek@suse.com (Petr Mladek)
Date: Tue, 9 Aug 2016 14:37:35 +0200
Subject: [PATCH v7 2/4] nmi_backtrace: do a local dump_stack() instead of
 a self-NMI
In-Reply-To: <1470672218-16059-3-git-send-email-cmetcalf@mellanox.com>
References: <1470672218-16059-1-git-send-email-cmetcalf@mellanox.com>
 <1470672218-16059-3-git-send-email-cmetcalf@mellanox.com>
Message-ID: <20160809123735.GF13300@pathway.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2016-08-08 12:03:36, Chris Metcalf wrote:
> Currently on arm there is code that checks whether it should call
> dump_stack() explicitly, to avoid trying to raise an NMI when the
> current context is not preemptible by the backtrace IPI.  Similarly,
> the forthcoming arch/tile support uses an IPI mechanism that does
> not support generating an NMI to self.
> 
> Accordingly, move the code that guards this case into the generic
> mechanism, and invoke it unconditionally whenever we want a
> backtrace of the current cpu.  It seems plausible that in all cases,
> dump_stack() will generate better information than generating a
> stack from the NMI handler.  The register state will be missing,
> but that state is likely not particularly helpful in any case.
> 
> Or, if we think it is helpful, we should be capturing and emitting
> the current register state in all cases when regs == NULL is passed
> to nmi_cpu_backtrace().
> 
> Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>
> Acked-by: Aaron Tomlin <atomlin@redhat.com>

Sounds and looks fine to me.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr Mladek
