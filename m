From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 27 Jan 2016 13:40:24 +1100
Subject: linux-next: build failure after merge of the aio tree
In-Reply-To: <20160112163835.GD347@kvack.org>
References: <20160112164034.0fe945a7@canb.auug.org.au>
 <20160112163835.GD347@kvack.org>
Message-ID: <20160127134024.0fababf6@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin,

On Tue, 12 Jan 2016 11:38:35 -0500 Benjamin LaHaise <bcrl@kvack.org> wrote:
>
> On Tue, Jan 12, 2016 at 04:40:34PM +1100, Stephen Rothwell wrote:
> > 
> > After merging the aio tree, today's linux-next build (arm
> > multi_v7_defconfig) failed like this:
> > 
> > fs/built-in.o: In function `aio_thread_op_foo_at':
> > file.c:(.text+0x43808): undefined reference to `__get_user_bad'
> > file.c:(.text+0x43838): undefined reference to `__get_user_bad'  
> 
> This is very strange.  It seems to imply that __get_user() doesn't 
> handle 64 bit values, which is completely broken behaviour on the 
> architecture's part if true.  Can any ARM folks comment on the right 
> fix here?

Well, probably only if you cc them :-)

Indeed, __get_user on arm does not handle 64 bit objects, where as
get_user does ...

Background: new aio code is adding __get_user() calls referencing 64
bit quantities (__u64 and __s64).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
