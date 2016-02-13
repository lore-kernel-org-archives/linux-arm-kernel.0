From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 13 Feb 2016 16:57:41 -0500 (EST)
Subject: [PATCH] [media] zl10353: use div_u64 instead of do_div
In-Reply-To: <CAKv+Gu8dFz28tGgQTv+WYAvKpeiFXaj8JANUFtOJwKPRsB8F5A@mail.gmail.com>
References: <1455287246-3540549-1-git-send-email-arnd@arndb.de>
 <2712691.b9gkR7KMX7@wuerfel>
 <alpine.LFD.2.20.1602121305180.13632@knanqh.ubzr>
 <6737272.LXr2g355Yt@wuerfel>
 <CAKv+Gu8dFz28tGgQTv+WYAvKpeiFXaj8JANUFtOJwKPRsB8F5A@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1602131652560.13632@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 13 Feb 2016, Ard Biesheuvel wrote:

> On 12 February 2016 at 22:01, Arnd Bergmann <arnd@arndb.de> wrote:
> > However, I did stumble over an older patch I did now, which I could
> > not remember what it was good for. It does fix the problem, and
> > it seems to be a better solution.
> >
> >         Arnd
> >
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index b5acbb404854..b5ff9881bef8 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -148,7 +148,7 @@ void ftrace_likely_update(struct ftrace_branch_data *f, int val, int expect);
> >   */
> >  #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
> >  #define __trace_if(cond) \
> > -       if (__builtin_constant_p((cond)) ? !!(cond) :                   \
> > +       if (__builtin_constant_p(!!(cond)) ? !!(cond) :                 \
> >         ({                                                              \
> >                 int ______r;                                            \
> >                 static struct ftrace_branch_data                        \
> >
> 
> I remember seeing this patch, but I don't remember the exact context.
> But when you think about it, !!cond can be a build time constant even
> if cond is not, as long as you can prove statically that cond != 0. So

You're right.  I just tested it and to my surprise gcc is smart enough 
to figure that case out.

> I think this change is obviously correct, and an improvement since it
> will remove the profiling overhead of branches that are not true
> branches in the first place.

Indeed.


Nicolas
