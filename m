From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 1 Oct 2016 22:39:15 +0200 (CEST)
Subject: [PATCH 00/15] improve function-level documentation
In-Reply-To: <1475353194.1996.3.camel@perches.com>
References: <1475351192-27079-1-git-send-email-Julia.Lawall@lip6.fr>
 <1475353194.1996.3.camel@perches.com>
Message-ID: <alpine.DEB.2.10.1610012232350.3445@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Sat, 1 Oct 2016, Joe Perches wrote:

> On Sat, 2016-10-01 at 21:46 +0200, Julia Lawall wrote:
> > These patches fix cases where the documentation above a function definition
> > is not consistent with the function header.  Issues are detected using the
> > semantic patch below (http://coccinelle.lip6.fr/).  Basically, the semantic
> > patch parses a file to find comments, then matches each function header,
> > and checks that the name and parameter list in the function header are
> > compatible with the comment that preceeds it most closely.
>
> Hi Julia.
>
> Would it be possible for a semantic patch to scan for
> function definitions where the types do not have
> identifiers and update the definitions to match the
> declarations?
>
> For instance, given:
>
> <some.h>
> int foo(int);
>
> <some.c>
> int foo(int bar)
> {
> 	return baz;
> }
>
> Could coccinelle output:
>
> diff a/some.h b/some.h
> []
> -int foo(int);
> +int foo(int bar);

The following seems to work:

@r@
identifier f;
position p;
type T, t;
parameter list[n] ps;
@@

T f at p(ps,t,...);

@s@
identifier r.f,x;
type r.T, r.t;
parameter list[r.n] ps;
@@

T f(ps,t x,...) { ... }

@@
identifier r.f, s.x;
position r.p;
type r.T, r.t;
parameter list[r.n] ps;
@@

T f at p(ps,t
+ x
  ,...);

After letting it run for a few minutes without making any effort to
include .h files, I get over 2700 changed lines.

julia
