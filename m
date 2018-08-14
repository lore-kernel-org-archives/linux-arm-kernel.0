From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 13 Aug 2018 20:03:59 -0400
Subject: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180813115019.GB28360@redhat.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
 <CAPhsuW49+qA7kT7yE4tgbnAuox-iOzssg-jc2abG8XDo6XeX8A@mail.gmail.com>
 <95a1221e-aecc-42be-5239-a2c2429be176@linux.ibm.com>
 <20180813115019.GB28360@redhat.com>
Message-ID: <20180813200359.31311bbb@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Aug 2018 13:50:19 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 08/13, Ravi Bangoria wrote:
> >
> > On 08/11/2018 01:27 PM, Song Liu wrote:  
> > >> +
> > >> +static void delayed_uprobe_delete(struct delayed_uprobe *du)
> > >> +{
> > >> +       if (!du)
> > >> +               return;  
> > > Do we really need this check?  
> >
> > Not necessary though, but I would still like to keep it for a safety.  
> 
> Heh. I tried to ignore all minor problems in this version, but now that Song
> mentioned this unnecessary check...
> 
> Personally I really dislike the checks like this one.
> 
> 	- It can confuse the reader who will try to understand the purpose
> 
> 	- it can hide a bug if delayed_uprobe_delete(du) is actually called
> 	  with du == NULL.
> 
> IMO, you should either remove it and let the kernel crash (to notice the
> problem), or turn it into
> 
> 	if (WARN_ON(!du))
> 		return;

I'd prefer the more robust WARN_ON(!du) above instead of removing it.

-- Steve
