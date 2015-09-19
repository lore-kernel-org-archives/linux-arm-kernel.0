From: andi@firstfloor.org (Andi Kleen)
Date: Sat, 19 Sep 2015 22:16:29 +0200
Subject: [PATCH 0/3] Add __ioread32_copy() and use it
In-Reply-To: <20150918121919.fa20552946703ae772d636e9@linux-foundation.org>
References: <1442346089-32077-1-git-send-email-sboyd@codeaurora.org>
 <20150915155815.5a41a8dc537610ab44d8d3dc@linux-foundation.org>
 <20150916023219.GD1747@two.firstfloor.org>
 <20150915195031.0a1756a2.akpm@linux-foundation.org>
 <20150916025546.GE1747@two.firstfloor.org>
 <20150918121919.fa20552946703ae772d636e9@linux-foundation.org>
Message-ID: <20150919201628.GI1747@two.firstfloor.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 12:19:19PM -0700, Andrew Morton wrote:
> On Wed, 16 Sep 2015 04:55:46 +0200 Andi Kleen <andi@firstfloor.org> wrote:
> 
> > > Under what circumstances will the compiler (or linker?) do this? 
> > 
> > Compiler.
> > 
> > > LTO enabled?
> > 
> > Yes it's for LTO.  The optimization allows the compiler to drop unused
> > functions, which is very popular with users (a lot use it to get smaller
> > kernel images)
> > 
> 
> Does this look truthful and complete?
> 
> 
> --- a/include/linux/compiler-gcc.h~a
> +++ a/include/linux/compiler-gcc.h
> @@ -205,7 +205,10 @@
>  
>  #if GCC_VERSION >= 40600
>  /*
> - * Tell the optimizer that something else uses this function or variable.
> + * When used with Link Time Optimization, gcc can optimize away C functions or
> + * variables which are referenced only from assembly code.  __visible tells the
> + * optimizer that something else uses this function or variable, thus preventing
> + * this.

Yes,

In a few cases I also used it to work around LTO bugs in older gcc
releases. I don't think any of those fixes made it into mainline though,
and they are not needed anymore with 5.x

-Andi
