From: mmarek@suse.com (Michal Marek)
Date: Fri, 21 Apr 2017 21:52:54 +0200
Subject: [RFC-b PATCH] kbuild: redefine __FILE__ as relative path from
 $(srctree) if possible
In-Reply-To: <1492803404-17837-1-git-send-email-yamada.masahiro@socionext.com>
References: <1492803404-17837-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <0f175fe5-6036-b06a-db90-6fd05ece7102@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 21.4.2017 v 21:36 Masahiro Yamada napsal(a):
> Since Kbuild runs in the objtree, __FILE__ can be a very long path
> depending of $(srctree).
> 
> Commit 9da0763bdd82 ("kbuild: Use relative path when building in a
> subdir of the source tree") made the situation better for cases
> where objtree is a child of srctree.  ($(srctree) is "..")
> 
> For other cases of out-of-tree build, filenames in WARN_ON() etc.
> are still an absolute path.  It also means the kernel image depends
> on where it was built.
> 
> Here, the idea is to redefine __FILE__ as the relative path from
> $(srctree), but doing so causes a compiler warning:
>   warning: "__FILE__" redefined [-Wbuiltin-macro-redefined]
> 
> We can suppress it with -Wno-builtin-macro-redefined.  However,
> this option is not recognized by old compilers.  So, __FILE__
> is re-defined only when the option is supported.

I actually like the KBUILD_FILE approach more, even if it means patching
various users.


> Please note __FILE__ is always an absolute path for external
> modules.  We can strip KBUILD_EXTMOD from the path if we want,
> but I am not doing that.  It would make it difficult to figure out
> the module in question in case of WARN_ON().

Agreed. OOT modules are potential source of trouble, so let them stand out.

Michal
