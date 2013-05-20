From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 20 May 2013 07:40:24 -0700
Subject: [PATCH] include/linux/posix_acl.h: need 'return NULL' when BUG(),
 if neither CONFIG_BUG nor HAVE_ARCH_BUG is defined.
In-Reply-To: <5199DBE2.5080707@asianux.com>
References: <5199DBE2.5080707@asianux.com>
Message-ID: <97dada79-cd78-4799-8f18-ed2bf8eee508@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Chen Gang <gang.chen@asianux.com> wrote:

>
>If neither CONFIG_BUG nor HAVE_ARCH_BUG is defined, the BUG() will
>defined as empty (e.g. randconfig with MMU for arm s5pv210)
>
>In this case, need 'return NULL' to let upper caller knows the failure.

Seriously?  The correct fix it would seem is to give a useful default BUG definition.  Say *NULL.

Further we should never hit that code in the first place if it calls BUG.  So upper callers should never get there.

If it is ever possible to get there the callers need to be fixed.

Eric

>Signed-off-by: Chen Gang <gang.chen@asianux.com>
>---
> include/linux/posix_acl.h |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)
>
>diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
>index 7931efe..2c48d06 100644
>--- a/include/linux/posix_acl.h
>+++ b/include/linux/posix_acl.h
>@@ -104,6 +104,7 @@ static inline struct posix_acl **acl_by_type(struct
>inode *inode, int type)
> 		return &inode->i_default_acl;
> 	default:
> 		BUG();
>+		return NULL;
> 	}
> }
> 
>-- 
>1.7.7.6
