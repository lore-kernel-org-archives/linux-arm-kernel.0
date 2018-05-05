From: bp@alien8.de (Borislav Petkov)
Date: Sat, 5 May 2018 11:58:05 +0200
Subject: [PATCH v3 01/12] ACPI / APEI: Move the estatus queue code up,
 and under its own ifdef
In-Reply-To: <20180427153510.5799-2-james.morse@arm.com>
References: <20180427153510.5799-1-james.morse@arm.com>
 <20180427153510.5799-2-james.morse@arm.com>
Message-ID: <20180505095805.GB3708@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 04:34:59PM +0100, James Morse wrote:
> To support asynchronous NMI-like notifications on arm64 we need to use
> the estatus-queue. These patches refactor it to allow multiple APEI
> notification types to use it.
> 
> First we move the estatus-queue code higher in the file so that any
> notify_foo() handler can make use of it.
> 
> This patch moves code around ... and makes the following trivial change:
> Freshen the dated comment above ghes_estatus_llist. printk() is no
> longer the issue, its the helpers like memory_failure_queue() that
> still aren't nmi safe.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>
> 
> Notes for cover letter:
> ghes.c has three things all called 'estatus'. One is a pool of memory
> that has a static size, and is grown/shrunk when new NMI users are
> allocated.
> The second is the cache, this holds recent notifications so we can
> suppress notifications we've already handled.
> The last is the queue, which hold data from NMI notifications (in pool
> memory) that can't be handled immediatly.
> ---
>  drivers/acpi/apei/ghes.c | 265 ++++++++++++++++++++++++-----------------------
>  1 file changed, 137 insertions(+), 128 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
