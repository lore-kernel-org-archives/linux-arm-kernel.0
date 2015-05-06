From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Wed, 6 May 2015 12:37:52 +0200
Subject: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT
 revision
In-Reply-To: <3577431.y872Foi4kj@wuerfel>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <1430902142-17035-2-git-send-email-pali.rohar@gmail.com>
 <3577431.y872Foi4kj@wuerfel>
Message-ID: <20150506103752.GG30910@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 May 2015 11:31:15 Arnd Bergmann wrote:
> On Wednesday 06 May 2015 10:49:01 Pali Roh?r wrote:
> > With this patch "revision" DT string entry is used to set global system_rev
> > variable. DT "revision" is expected to be string with one hexadecimal number.
> > So "Revision" line in /proc/cpuinfo will be same as "revision" DT value.
> > 
> > Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> +devicetree mailing list
> 
> The property needs to be specified in a binding somewhere.
> 
> > @@ -246,5 +247,14 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
> >  	/* Change machine number to match the mdesc we're using */
> >  	__machine_arch_type = mdesc->nr;
> >  
> > +	/* Set system revision from DT */
> > +	prop = of_get_flat_dt_prop(dt_root, "revision", &size);
> > +	if (prop && size > 0) {
> > +		char revision[11];
> > +		strlcpy(revision, prop, min(size, (int)sizeof(revision)));
> > +		if (kstrtouint(revision, 16, &system_rev) != 0)
> > +			system_rev = 0;
> > +	}
> > +
> >  	return mdesc;
> >  }
> > 
> 
> What is the reason for doing it this early? I think it would be nicer to do
> it after unflattening the DT.
> 

It needs to be done in this code, so "system_rev" variable is set
properly...

> Also, it seems strange to have a string property and then use kstrtouint
> to convert it into a number. I think it should either be specified in a DT
> binding to be a string and then have the kernel not assume that it is a number,
> or we should define it to be binary.
> 
> 	Arnd

Variable "system_rev" is number and it always was. So chaning type will
break more parts.

And it is string DT property to be human readable. Some other developers
suggested for v2 to change it to string (from number).

-- 
Pali Roh?r
pali.rohar at gmail.com
