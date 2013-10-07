From: broonie@kernel.org (Mark Brown)
Date: Mon, 7 Oct 2013 18:27:06 +0100
Subject: [RFC] ASoC: pcm: Trigger all commands on error
In-Reply-To: <1380883997-18236-1-git-send-email-mpa@pengutronix.de>
References: <1380883997-18236-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20131007172706.GS21581@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 04, 2013 at 12:53:17PM +0200, Markus Pargmann wrote:

> In case of a start command, the calling function will call undo_start,
> calling this trigger function with the stop command. It will call stop
> for each function. But only the first function was started previously.
> The other functions may fail in the assumption that a stop command
> always comes after a start command.

> As the API does not specify the behaviour of trigger functionpointers, I
> think this should be fixed in the function calling the trigger
> functionpointers.

> This patch changes the behaviour. The trigger function calls all
> functionpointers independent of their returncodes. The first error-code
> is returned.

I'm not sure if this will resolve the problem robustly - if something is
going to get confused about this it seems just as likely that the
trigger that failed will get upset because it gets a _STOP after
returning an error from _START.  I think what I'd expect here is that
the unwind on error would unwind only the triggers that it successfully
ran.  Equally well I'd be a bit surprised if a trigger function actually
had a problem with extra _STOPs since they mostly just do register
writes...  did you see this from code inspection or were you resolving a
practical problem in your system?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131007/f6867cdc/attachment.sig>
