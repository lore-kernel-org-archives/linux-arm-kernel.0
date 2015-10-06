From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Oct 2015 11:45:15 +0100
Subject: [PATCH v6 21/22] driver core: Start processing deferred probes
 earlier
In-Reply-To: <CAL_JsqKBKSsvEuoufc=xesSvcA1bf-X43O0YOvuntUJE5NYCJA@mail.gmail.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442844182-27787-22-git-send-email-tomeu.vizoso@collabora.com>
 <56130D43.10200@gmail.com>
 <CAL_JsqKBKSsvEuoufc=xesSvcA1bf-X43O0YOvuntUJE5NYCJA@mail.gmail.com>
Message-ID: <20151006104515.GJ12635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2015 at 09:49:38PM -0500, Rob Herring wrote:
> On Mon, Oct 5, 2015 at 6:52 PM, Frank Rowand <frowand.list@gmail.com> wrote:

> > The purpose of the *_sync initcall levels is to allow the corresponding
> > initcall level to use multiple threads of execution instead of a single
> > thread.  The *_sync level provides a location for a wait for all of the
> > threads at the corresponding init level to complete.  This is better
> > explained in the git log:

> The things I was worried about like clk and regulator disabling are
> actually late_initcall_sync, so maybe late_initcall is fine here after
> all.

> However, looking at other *_initcall_sync users, I'm not so sure they
> are doing the same abuse.

They're trying to run at the point where we've completed deferred
probe processing - in other words, at the sync point.  What they really
want is an additional callback at the point where the syncs have
actually happened.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151006/e75e2ea5/attachment.sig>
