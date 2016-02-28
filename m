From: tiwai@suse.de (Takashi Iwai)
Date: Sun, 28 Feb 2016 09:48:39 +0100
Subject: [PATCH] ASoC: trace: fix printing jack name
In-Reply-To: <20160224115037.40772a90@gandalf.local.home>
References: <1456331903-3999234-1-git-send-email-arnd@arndb.de>
 <20160224115037.40772a90@gandalf.local.home>
Message-ID: <s5hlh65i5js.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Feb 2016 17:50:37 +0100,
Steven Rostedt wrote:
> 
> On Wed, 24 Feb 2016 17:38:14 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > After a change to the snd_jack structure, the 'name' member
> > is no longer available in all configurations, which results in a
> > build failure in the tracing code:
> > 
> > include/trace/events/asoc.h: In function 'trace_event_raw_event_snd_soc_jack_report':
> > include/trace/events/asoc.h:240:32: error: 'struct snd_jack' has no member named 'name'
> > 
> > The name field is normally initialized from the card shortname and
> > the jack "id" field:
> > 
> >         snprintf(jack->name, sizeof(jack->name), "%s %s",
> >                  card->shortname, jack->id);
> > 
> > This changes the tracing output to just contain the 'id' by
> > itself, which slightly changes the output format but avoids the
> > link error and is hopefully still enough to see what is going on.
> 
> If people would like name if available, we could do:
> 
> #ifdef CONFIG_SND_JACK_INPUT_DEV
> # define JACK_NAME(jk)		(jk)->jack->name
> #else
> # define JACK_NAME(jk)		(jk)->jack->id
> #endif
> 
> And then below have:
> 
> 	__string(	name,	JACK_NAME(jack)	)
> 
> 
> The #ifdef can stay in the events/asoc.h file.

I don't mind either way.  Mark, what do you think?

In anyway, the breakage came from my tree, so I'm going to apply the
fix directly on mine.


thanks,

Takashi

> 
> -- Steve
> 
> 
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Fixes: fe0d128c57bf ("ALSA: jack: Allow building the jack layer without input device")
> > ---
> >  include/trace/events/asoc.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
> > index 317a1ed2f4ac..9130dd5a184a 100644
> > --- a/include/trace/events/asoc.h
> > +++ b/include/trace/events/asoc.h
> > @@ -231,13 +231,13 @@ TRACE_EVENT(snd_soc_jack_report,
> >  	TP_ARGS(jack, mask, val),
> >  
> >  	TP_STRUCT__entry(
> > -		__string(	name,		jack->jack->name	)
> > +		__string(	name,		jack->jack->id		)
> >  		__field(	int,		mask			)
> >  		__field(	int,		val			)
> >  	),
> >  
> >  	TP_fast_assign(
> > -		__assign_str(name, jack->jack->name);
> > +		__assign_str(name, jack->jack->id);
> >  		__entry->mask = mask;
> >  		__entry->val = val;
> >  	),
> > @@ -253,12 +253,12 @@ TRACE_EVENT(snd_soc_jack_notify,
> >  	TP_ARGS(jack, val),
> >  
> >  	TP_STRUCT__entry(
> > -		__string(	name,		jack->jack->name	)
> > +		__string(	name,		jack->jack->id		)
> >  		__field(	int,		val			)
> >  	),
> >  
> >  	TP_fast_assign(
> > -		__assign_str(name, jack->jack->name);
> > +		__assign_str(name, jack->jack->id);
> >  		__entry->val = val;
> >  	),
> >  
> 
