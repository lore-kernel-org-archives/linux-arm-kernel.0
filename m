From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 12 May 2011 09:42:10 +1200
Subject: [PATCH 5/9] at91: use structure to store the current soc
In-Reply-To: <4DCA4930.4070609@atmel.com>
References: <20110510162730.GA18929@game.jcrosoft.org>	<1305045259-23066-5-git-send-email-plagnioj@jcrosoft.com>	<4DC9B422.6070205@bluewatersys.com>	<20110510234033.GB18929@game.jcrosoft.org>	<4DC9DAAC.7060506@bluewatersys.com>	<20110511032633.GG18929@game.jcrosoft.org>	<4DCA0CB8.6060205@bluewatersys.com>	<20110511041951.GD22009@game.jcrosoft.org>
	<4DCA4930.4070609@atmel.com>
Message-ID: <4DCB02B2.2000301@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2011 08:30 PM, Nicolas Ferre wrote:
> Hi all,
> 
> Le 11/05/2011 06:19, Jean-Christophe PLAGNIOL-VILLARD :
>> On 16:12 Wed 11 May     , Ryan Mallon wrote:
>>> On 05/11/2011 03:26 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>> On 12:39 Wed 11 May     , Ryan Mallon wrote:
>>>>> On 05/11/2011 11:40 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:

<snip>

>>>> furthermore we associate the subtype with the subtype name where each entry
>>>> are uniq
>>>
>>> You could add:
>>>
>>> 	const char *name;
>>> 	char *subtype_name;
>>>
>>> To at91_soc_data. The name field can be directly assigned in the
>>> at91xxx.c files and the subtype name can be assigned when it is detected
>>> (which is why it can't be const). The removes the need for the
>>> type/subtype lookup tables.
>> no as we need to stock all the soc name here and it much more clear to get
>> them together and link to the enum type
>>
>> and if the soc is not enable you can not have the name so impossible to inform
>> the user about which we detect and this will add too much ifdef
> 
> Yes, the main argument here is that we should tell the use which chips
> is actually detected even if its support is not included in the kernel
> configuration.
> 
> [..]

Yes, I didn't think of that. However, it should still be possible to
mark the name lookup tables as __initdata and then copy the correct
strings into the at91_soc_data struct. This means that we have the
ability to print the name of the detected soc at init time (in case the
soc is not compiled in), but also means that we can free the lookup
tables up once we know the correct soc, and the functions for getting
the names become direct pointer accesses.

<snip>

>>>>>>> I would still like to see if it is possible to reorder these patches so
>>>>>>> that this intermediate rewrite is not needed.
>>>>>> there is none intermedaite write
>>>>>
>>>>> You snipped it out in the reply :-). Patch 2/9 adds soc detection in
>>>>> at91_map_io via a series of 'if (cpu_is_xxx)' statements. This patch
>>>>> then removes that method and replaces it with the switch statement in
>>>>> soc_detect. It would be nice to try and avoid the intermediate step in
>>>>> at91_map_io since it only exists for three commits.
>>>> no this two different changes with huge impact
>>>> first one factorize the map_io and change the AT91_BASE_SYS
>>>>
>>>> so I do prefer to keep them seperated and bre able to bisect them
>>>
>>> This patch could be made the first patch in the series since it doesn't
>>> (AFAICT) depend on AT91_BASE_SYS being generic since it uses internal
>>> defines for the two DBGU bases. So this patch would introduce an
>>> (possibly unused) soc_detection function, which can be put into use by
>>> the subsequent patches.
>>>
>>> This would make the patch series easier to review since the change to
>>> move to soc detection only gets made once, not twice as it is now.
>>
>> no I prefer to change the AT91_BASE_SYS first and touch the board
>> then add the real soc detection
>>
>> The change of the memory must be first and it's impact alot of code
> 
> I think that there is no big requirement in relation with patches order.
> As long as the "bisect" is possible and that it has a reasonable order,
> I tend to think that it is ok.

The reason I would like to see the order change is that I think it will
reduce the size of each patch since the intermediate having the soc
detection in at91_map_io will not need to exist. This makes it easier to
review patches and means that there is no need to worry about bugs in
the intermediate steps which get fixed in the later steps. Bisecting
would still be possible.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
