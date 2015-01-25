From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 25 Jan 2015 16:03:41 +0100 (CET)
Subject: [PATCH 1/2] clockevents: introduce ->set_dev_mode() which can
 return error
In-Reply-To: <CAKohpomZJAymPHVNR9LkHM8V2tkmM=H+btYEiAJ9hq0mAoOzYw@mail.gmail.com>
References: <1418162614-19182-1-git-send-email-khilman@kernel.org>
 <1418162614-19182-2-git-send-email-khilman@kernel.org>
 <alpine.DEB.2.11.1501231223470.5526@nanos>
 <CAKohpomZJAymPHVNR9LkHM8V2tkmM=H+btYEiAJ9hq0mAoOzYw@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1501251537380.5526@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >         case CLOCK_EVT_MODE_RESUME:
> >              return dev->setup_resume(dev);
> 
> Because setting to all these existing modes isn't allowed
> to fail currently, shouldn't we make return type of all the new
> callbacks as 'void' and return 0 from this routine ? That way, these
> callbacks would stay consistent with the set_mode() callback..

If we go to individual callbacks then we analyze of a case by case
basis which ones need a return value and which ones to not.
 
> > That gives us a clear distinction of required and optional callbacks,
> > which will make error handling and recovery simpler as well.
> 
> Now that we are looking forward to providing individual callbacks
> per feature, I wanted to propose few more solutions to it, though I am
> quite sure you would have already considered and rejected them.
> 
> I remember from your earlier mail that you didn't wanted to add
> ONESHOT_STOPPED as a feature (as it isn't a feature really)
> and that restricts us from doing this:
> 
> static int __clockevents_set_mode(dev, mode)
> {
>         if ((mode == CLOCK_EVT_MODE_ONESHOT_STOPPED) &&
>             !(dev->features & CLOCK_EVT_FEAT_ONESHOT_STOPPED))
>                 return -ENOSYS;
> 
>         dev->set_mode(mode, dev);
>         return 0;
> }
> 
> But what about providing a separate callback only for ONESHOT_STOPPED
> mode and use set_mode() for everything else ?

And then fixup all drivers which do not have a default clause in their
switch case and add MODE_ONESHOT_STOPPED? And half a year later we do
the same for the next mode. No way.

The current interface is suboptimal and we fix it proper. Period.

Thanks,

	tglx
