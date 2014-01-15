From: jason.wessel@windriver.com (Jason Wessel)
Date: Wed, 15 Jan 2014 10:44:27 -0600
Subject: [PATCH v6 3/3] KGDB: make kgdb_breakpoint() as noinline
In-Reply-To: <1387453851-19341-4-git-send-email-vijay.kilari@gmail.com>
References: <1387453851-19341-1-git-send-email-vijay.kilari@gmail.com>
 <1387453851-19341-4-git-send-email-vijay.kilari@gmail.com>
Message-ID: <52D6BAEB.3040607@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2013 05:50 AM, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
>
> The function kgdb_breakpoint() sets up break point at
> compile time by calling arch_kgdb_breakpoint();
> Though this call is surrounded by wmb() barrier,
> the compile can still re-order the break point,
> because this scheduling barrier is not a code motion
> barrier in gcc.
>
> Making kgdb_breakpoint() as noinline solves this problem
> of code reording around break point instruction and also
> avoids problem of being called as inline function from
> other places
>
> More details about discussion on this can be found here
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/269732
>
> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
> Acked-by: Will Deacon <will.deacon@arm.com>

Acked-by: Jason Wessel <jason.wessel@windriver.com>


Cheers,
Jason.

> ---
>  kernel/debug/debug_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 7d2f35e..cf04798 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -1034,7 +1034,7 @@ int dbg_io_get_char(void)
>   * otherwise as a quick means to stop program execution and "break" into
>   * the debugger.
>   */
> -void kgdb_breakpoint(void)
> +noinline void kgdb_breakpoint(void)
>  {
>  	atomic_inc(&kgdb_setting_breakpoint);
>  	wmb(); /* Sync point before breakpoint */
