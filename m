From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 18 Nov 2013 12:01:02 -0700
Subject: [RFC PATCH V2 1/2] dtc: add 'compat' output option, prints board
 string
In-Reply-To: <728deb9bbeab491a728da077aa5e47c0e01bccf8.1384798508.git.jason@lakedaemon.net>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <cover.1384798508.git.jason@lakedaemon.net>
 <728deb9bbeab491a728da077aa5e47c0e01bccf8.1384798508.git.jason@lakedaemon.net>
Message-ID: <528A63EE.8050401@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2013 11:38 AM, Jason Cooper wrote:
> Consumers of the Linux kernel's build products are beginning to hardcode
> the filenames of the dtbs generated.  Since the dtb filenames are
> currently the dts filename s/dts/dtb/, this prevents the kernel
> community from renaming dts files as needed.
> 
> Let's provide a consistent naming structure for consumers to script
> against.  Or at least, as consistent as the dts properties themselves.
> 
> With this patch, adding the '-O compat' option to the dtc commandline
> will cause dtc to parse the provided file, and print out the board
> compatible string to stdout.
> 
> This will facilitate an 'installdtbs.sh' script in the kernel for naming
> dtb files by their compatible string, eg:
> 
> $ dtc -I dtb -O compat arch/arm/boot/dts/armada-370-mirabox.dtb
> globalscale,mirabox
> 
> This change will also simplify distribution install scripts that need to
> search through many dtbs to find the right one for a target board.
> 
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> ---
> changes since v1:
>  - made patch against in-tree dtc code to facilitate testing

I assume this patch would first get applied to the upstream dtc, then
back-ported into the kernel though?

I wonder if dtc is the correct place to put this feature at all though.
It seems like a tiny standalone utility using libfdt would be better.
Actually, perhaps the existing fdtget utility (which seems to be
scripts/dtc/fdtget.c in the kernel although I don't know if it's built
by the kernel yet) can be used rather than creating a new one? Using
fdtget seems like it'd allow more flexibility later, if the naming rules
change, via scripting rather than having to edit the dtc source code.
