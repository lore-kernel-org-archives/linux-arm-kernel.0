From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Nov 2011 19:42:13 +0000
Subject: [PATCH 4/4] ARM: add jump label support
In-Reply-To: <1321888429-3519-4-git-send-email-rabin@rab.in>
References: <1321888429-3519-1-git-send-email-rabin@rab.in>
 <1321888429-3519-4-git-send-email-rabin@rab.in>
Message-ID: <20111122194213.GC9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 08:43:49PM +0530, Rabin Vincent wrote:
> Add the arch-specific code to support jump labels for ARM and Thumb-2.
> 
> Note that to build succesfully it requires (what will be) GCC 4.7.0
> because of incomplete support for the '%c' specifier in earlier
> versions:
> 
> 	http://gcc.gnu.org/bugzilla/show_bug.cgi?id=48637
> 
> Cc: Jason Baron <jbaron@redhat.com>
> Signed-off-by: Rabin Vincent <rabin@rab.in>

This appears to imply that with this patch, we're upping the minimum
gcc version for successfully building kernels to 4.7.0.  That's _way_
too early (I'm using 4.3.5 here and don't have plans to update.)

> +static inline unsigned long
> +arm_gen_nop(void)
> +{
> +#ifdef CONFIG_THUMB2_KERNEL
> +	return 0xf3af8000; /* nop.w */
> +#elif defined(CONFIG_CPU_32v6K)
> +	return 0xe320f000; /* nop */
> +#else
> +	return 0xe1a00000; /* mov r0, r0 */

There really is no point making the distinction between the new nop
and the old nop instructions.  The difference between them is that the
new nop is a true 'no operation' whereas the old nop causes exactly
what the instruction says to happen - which in effect is a no-op.

Obviously, doing a true no-operation may require in less power, but
if you're using this code, you're debugging, so power usage isn't
really a concern.  So lets keep the code simple and just use the old
nop here.  It won't go away.
