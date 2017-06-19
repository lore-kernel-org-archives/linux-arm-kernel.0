From: james.morse@arm.com (James Morse)
Date: Mon, 19 Jun 2017 17:16:42 +0100
Subject: [PATCH 16/20] arm64: signal32: move ilp32 and aarch32 common
 code to separated file
In-Reply-To: <20170604120009.342-17-ynorov@caviumnetworks.com>
References: <20170604120009.342-1-ynorov@caviumnetworks.com>
 <20170604120009.342-17-ynorov@caviumnetworks.com>
Message-ID: <5947F8EA.9000209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yury,

On 04/06/17 13:00, Yury Norov wrote:
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

Can I offer a body for the commit message:
ILP32 needs to mix 32bit struct siginfo and 64bit sigframe for its signal
handlers. Move the existing compat code for copying siginfo to user space and
manipulating signal masks into signal32_common.c so it can be used to deliver
aarch32 and ilp32 signals.


> diff --git a/arch/arm64/include/asm/signal32.h b/arch/arm64/include/asm/signal32.h
> index e68fcce538e1..1c4ede717bd2 100644
> --- a/arch/arm64/include/asm/signal32.h
> +++ b/arch/arm64/include/asm/signal32.h
> @@ -13,6 +13,9 @@
>   * You should have received a copy of the GNU General Public License
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
> +
> +#include <asm/signal32_common.h>
> +
>  #ifndef __ASM_SIGNAL32_H
>  #define __ASM_SIGNAL32_H

Nit: This should go inside the guard.


> diff --git a/arch/arm64/kernel/signal32_common.c b/arch/arm64/kernel/signal32_common.c
> new file mode 100644
> index 000000000000..5bddc25dca12
> --- /dev/null
> +++ b/arch/arm64/kernel/signal32_common.c
> @@ -0,0 +1,135 @@
[...]
> +#include <linux/compat.h>
> +#include <linux/signal.h>
> +#include <linux/ratelimit.h>

What do you need ratelimit.h for?


> +#include <linux/uaccess.h>
> +
> +#include <asm/esr.h>

I can't see anything using these ESR_ macros in here...


> +#include <asm/fpsimd.h>

This was for the VFP save/restore code, which you didn't move...


> +#include <asm/signal32_common.h>
> +#include <asm/unistd.h>

[...]


> +int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
[...]
> +	case __SI_FAULT:
> +		err |= __put_user((compat_uptr_t)(unsigned long)from->si_addr,
> +				  &to->si_addr);

This looks tricky. si_addr comes from FAR_EL1 when user-space touches something
it shouldn't. This could be a 64bit value as ilp32 processes can still branch to
64bit addresses in registers and generate loads that cross the invisible 4GB
boundary. Here you truncate the 64bit address.
Obviously this can't happen at all with aarch32, and for C programs its into
undefined-behaviour territory, but it doesn't feel right to pass an address to
user-space that we know is wrong... but we don't have an alternative.

This looks like a class of problem particular to ilp32/x32: 'accessed an address
you can't encode with a signal'. After a quick dig in x86's x32 code, it looks
like they only pass the first 32bits of si_addr too.

One option is to mint a new si_code to go with SIGBUS meaning something like
'address overflowed si_addr'. Alternatively we could just kill tasks that do this.


Thanks,

James
