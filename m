From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 19 Jun 2011 22:11:00 +0200
Subject: [PATCH] USB: ehci: use packed,
	aligned(4) instead of removing the packed attribute
In-Reply-To: <201106192202.23989.arnd@arndb.de>
References: <Pine.LNX.4.44L0.1106191453200.14586-100000@netrider.rowland.org>
	<201106192202.23989.arnd@arndb.de>
Message-ID: <201106192211.01076.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 19 June 2011 22:02:23 Arnd Bergmann wrote:
> In this case, we would have to do
> 
> struct s {
>         char c[2];
> } __packed;
> 
> struct t {
>         struct s t1;
>         unsigned short t2[3] __aligned(2);
> } __packed;
> 
> To tell the compiler that t2 is indeed aligned, while struct t
> is packed to include no padding around t.
>  
> I actually recently stumbled over code that gets this wrong,
> see
> 
> http://git.kernel.org/?p=linux/kernel/git/arnd/playground.git;a=commit;h=284cef173aafd531a708f48e71a9cc7249fc8a98
> 

Just to be clear: none of the ehci structures fall into this category.
I would assume that we actually have a few more drivers with this
bug in the kernel, but the patch proposed by Alexander would not
help with this problem, and the EHCI driver is still correct without
__packed.

	Arnd
