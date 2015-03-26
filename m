From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 26 Mar 2015 15:15:57 -0700
Subject: String literals in __init functions
In-Reply-To: <1427407120.15849.34.camel@perches.com>
References: <5512F6C6.1020304@free.fr> <1427306517.2717.0.camel@perches.com>
 <5513FE2F.3040306@free.fr> <1427386390.15849.13.camel@perches.com>
 <CA+rthh9Fb2q+O_wicc6eNcbo6SzwOVZed=tnThJLF-xuoQ-+Cw@mail.gmail.com>
 <1427392393.15849.16.camel@perches.com>
 <CA+rthh8irf+tTSbomivu=bgN-L1k99TQ-q6UYgmMRC1PNOG7qw@mail.gmail.com>
 <20150326144058.56ef6916b00ad38030296089@linux-foundation.org>
 <1427407120.15849.34.camel@perches.com>
Message-ID: <20150326151557.61dfad84272aff10aaa4eba7@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Mar 2015 14:58:40 -0700 Joe Perches <joe@perches.com> wrote:

> > I'd have thought that a function-wide
> > 	__attribute__((__string_section__(foo))
> > wouldn't be a ton of work to implement.
> 
> Maybe not.
> 
> Could some future version of gcc move string constants
> in a function to a specific section marked in a manner
> similar to what Andrew described above?

One thing which might complexicate this is

void foo()
{
	p("bar");
}

void  __attribute__((__string_section__(.init.rodata)) zot()
{
	p("bar");
}

It would be silly to create two instances of "bar".

Change it thusly:


#define __mark_str(str) \
	({ static const char var[] __attribute__((__section__(".init.string"))) = str; var; })

void foo()
{
	p("bar");
}

void zot()
{
	p(__mark_str("bar"));
}


and we indeed get two copies of "bar".

It would be nice not to do that, but I guess that losing this
optimization is a reasonable compromise.
