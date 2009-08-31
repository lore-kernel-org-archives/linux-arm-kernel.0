From: wim@iguana.be (Wim Van Sebroeck)
Date: Mon, 31 Aug 2009 14:35:00 +0200
Subject: [PATCH] watchdog: Add support for the Avionic Design Xanthos
	watchdog timer.
In-Reply-To: <4A9733C9.9090900@billgatliff.com>
References: <20090821073105.GC29382@infomag.iguana.be>
	<1250860202-28187-1-git-send-email-thierry.reding@avionic-design.de>
	<20090822081806.GD29382@infomag.iguana.be>
	<20090824090407.GA24894@avionic-design.de>
	<20090827202314.GJ29382@infomag.iguana.be>
	<4A96ED32.7000108@billgatliff.com>
	<20090827204448.GL29382@infomag.iguana.be>
	<4A9733C9.9090900@billgatliff.com>
Message-ID: <20090831123500.GN29382@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bill,

>>>> This is the only thing I'm still struggling with: the goal of a watchdog device driver is to make sure that the system reboots when the system isn't stable anymore. So why should you then trigger the interrupt?
>>>>         
>>> ... because a hard reboot might not be the way he wants to resolve 
>>> the  situation.
>>>     
>>
>> If your system is unstable then sending a keepalive to the watchdog during this interrupt is not going to change anything neither... Or am I missing something?
>>   
>
> All I'm saying is that it isn't always a given that a watchdog timeout  
> should universally issue a hardware reset.  I've worked with systems  
> where doing so would be a Really Bad Idea, and what we wanted instead  
> was the ability to know when the watchdog timer had expired so that we  
> could wrest control of the system away from the application.
>
> Put another way, it isn't always the case that the _system_ has become  
> unstable.  It's more likely that the _application_ has, and there are  
> other ways to fix that than by issuing a hardware reset.
>
> In the bigger picture, getting all the benefits out of a watchdog timer  
> while at the same time avoiding their limitations can be a tricky  
> business.  They're misused far more often than used properly,  
> unfortunately.  I sense that you and I both recognize that.

The original watchdog API was designed to make sure that unstable systems, systems that are going in a deadlock situation, can be recovered by a reboot.
And this is still how we use the watchdog API. The goal is to keep the system running. 

So if (and I can imagine that certain embedded applications might need this) a system is wanted to restart unstable applications, then (for me) this means that you want another functionality then what we have now. This can be an extension of the current watchdog API, but it's not said that this is the best solution.

For me the core function of a linux watchdog device driver is and remains to make sure that a system get's rebooted if it crashes.
Monitoring applications and other pheripherals looks to me additional finetuning of your system (and can indeed be usefull or needed). For applications monitoring there are imho other tools allready available (example: we used a heavily modified version of spong in the late 90's to test mail, dns, radius, ...). 

Kind regards,
Wim.
