From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 23:08:13 +0100
Subject: [PATCH] sound: hdmi: avoid dereferencing uninitialized 'jack'
 pointer
In-Reply-To: <2706488.VpKveMVPGI@wuerfel>
References: <1455634059-1896914-1-git-send-email-arnd@arndb.de>
 <s5hr3gc60ph.wl-tiwai@suse.de> <2706488.VpKveMVPGI@wuerfel>
Message-ID: <3395859.dhsfOsmVIe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 February 2016 18:26:09 Arnd Bergmann wrote:
> >                 return err;
> >         per_pin->acomp_jack = jack;
> > -       jack->private_data = per_pin;
> > -       jack->private_free = free_acomp_jack_priv;
> > +       if (jack) {
> > +               jack->private_data = per_pin;
> > +               jack->private_free = free_acomp_jack_priv;
> > +       }
> >         return 0;
> >  }
> > 
> Looks good to me.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 

Actually, on second thought, there is one notable downside
of this approach: 'jack' is guaranteed to be NULL here, so gcc
won't produce a warning if another driver makes the same mistake:

By default, we only get a warning for uses of uninitialized
variables, but not those that are known to be NULL. I think
some compiler warnings are able to warn about that too, but I
forgot the details.

	Arnd
