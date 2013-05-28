From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 May 2013 19:20:37 +0200
Subject: [PATCH] arch: configuration,
 deleting 'CONFIG_BUG' since always need it.
In-Reply-To: <51A4D618.3080208@zytor.com>
References: <519DCBEF.3090208@asianux.com> <201305281743.52649.arnd@arndb.de>
 <51A4D618.3080208@zytor.com>
Message-ID: <201305281920.37452.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 May 2013, H. Peter Anvin wrote:
> On 05/28/2013 08:43 AM, Arnd Bergmann wrote:
> > 
> > Right, that is what the patch I just posted does.
> > 
> > On a related note, I found that WARN_ON() can no longer be compiled
> > out since there is already code that relies on the side-effects of
> > the condition. I assume that was an intentional change I missed,
> > since it used to be defined so that you could remove it completely.
> > 
> 
> It is possible to define WARN_ON() as:
> 
> #define WARN_ON(x) ((void)(x))
> 
> ... which preserves side effects.

Yes, actually the return value has to be maintained as well.
The current (!CONFIG_BUG) default implementation is

#define WARN_ON(condition) ({                                           \
        int __ret_warn_on = !!(condition);                              \
        unlikely(__ret_warn_on);                                        \
})

which seems fine.

#define WARN_ON(condition) unlikely(!!(condition))

is probably just as good.

	Arnd
