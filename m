From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Tue, 21 Nov 2017 18:46:25 +0100
Subject: [PATCH] arm: ensure symbol is a thumb symbol in new binutils
In-Reply-To: <20171121173857.GJ31757@n2100.armlinux.org.uk>
References: <20171121172751.29545-1-Jason@zx2c4.com>
 <20171121173857.GJ31757@n2100.armlinux.org.uk>
Message-ID: <CAHmME9quDFbdOR9hKRz-Px=Mh3FvYEyhVrs4V_+JT+GjDajMrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Nov 21, 2017 at 6:38 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> +toolcheck:
> +       @$(CONFIG_SHELL) '$(srctree)/$(src)/toolcheck'

Perhaps faster to put the check for THUMB2_KERNEL around the make
target, instead of doing it in the code?

> +if grep -q 'CONFIG_THUMB2_KERNEL=y' .config; then

See above.

> +   tmp=$(mktemp -d /tmp/binutils-test.XXXXXXXXXX)
> +   cat <<EOF | $AS $ASFLAGS -o $tmp/test.o
> +       .syntax unified
> +       .thumb
> +       .macro  badr, reg, sym
> +       adr     \reg, \sym + 1
> +       .endm
> +
> +test:
> +       mov     r0, #0
> +       badr    lr, test
> +EOF
> +   if ! $OBJDUMP -d $tmp/test.o | grep -q '4:\s*f2af 0e07'; then
> +      echo "Error: your assembler version produces buggy kernels" >&2
> +      $AS --version | head -n1 >&2
> +      rm $tmp/*.o
> +      rmdir $tmp
> +      exit 1
> +   fi
> +   rm $tmp/*.o
> +   rmdir $tmp
> +fi

This doesn't actually catch the issues. In the buggy binutils, it
appears that sometimes adr grabs the right symbol and sometimes it
doesn't. I'm not yet able to figure out a minimal condition for it
going one way or the other.

Jason
