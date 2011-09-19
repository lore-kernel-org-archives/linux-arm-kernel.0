From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Sep 2011 10:52:34 +0200
Subject: [PATCH] ARM: supply a DTB file to be appended
In-Reply-To: <1315476884-28470-1-git-send-email-linus.walleij@stericsson.com>
References: <1315476884-28470-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CACRpkdZ+s_y=4VJuz5WetaU1tUFF-f6g38bpy6TSRjt9Q_VgLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2011 at 12:14 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:

> This makes it easy to script the kernel build with
> different device trees, and it also vastly simplifies
> building uImages since "make uImage" will now pick
> up the devcie tree and include it in the final image
> as part of the build process.

A clarification here on what it actually simplifies.

make zImage
cat my.dtb >> arch/arm/boot/zImage
make uImage

Does *not* work.

The reason is that when you issue "make uImage"
the zImage is overwritten due to changed timestamp.
Then a uImage without the DTB is created.

So currently to generate a uImage you have to
do something like:

make zImage
cat my.dtb >> arch/arm/boot/zImage
mkimage -A arm -O linux -T kernel -C none -a 0x00008000 -e 0x00008000
-n 'Linux-3.0' -d arch/arm/boot/zImage arch/arm/boot/uImage

The patch folds all of this into:

make uImage

Yours,
Linus Walleij
