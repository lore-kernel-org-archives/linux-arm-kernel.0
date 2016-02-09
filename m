From: brian.starkey@arm.com (Brian Starkey)
Date: Tue, 9 Feb 2016 10:23:00 +0000
Subject: [RESEND2 PATCH 1/3] memremap: add MEMREMAP_WC flag
In-Reply-To: <20160208120317.313409dc0ae7634c25d3f021@linux-foundation.org>
References: <cover.1454950917.git.brian.starkey@arm.com>
 <9085d37fa97a762a46b9d58719c085368682c64f.1454950917.git.brian.starkey@arm.com>
 <20160208120317.313409dc0ae7634c25d3f021@linux-foundation.org>
Message-ID: <20160209102300.GB23507@e106950-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Thanks for taking a look,

On Mon, Feb 08, 2016 at 12:03:17PM -0800, Andrew Morton wrote:
>On Mon,  8 Feb 2016 17:30:50 +0000 Brian Starkey <brian.starkey@arm.com> wrote:
>The patch generally looks OK to me.  It generates rejects against
>linux-next because of some janitorial changes in memremap.c.
>

Ah yeah, so it does - sorry. I was hoping this could make it into 4.5,
but I can rebase onto linux-next if that's better. Annoyingly it only
conflicts because of a couple of quotation marks.

>
>> @@ -101,6 +107,11 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
>>  		addr = ioremap_wt(offset, size);
>>  	}
>>
>> +	if (!addr && (flags & MEMREMAP_WC)) {
>> +		flags &= ~MEMREMAP_WC;
>> +		addr = ioremap_wc(offset, size);
>> +	}
>> +
>>  	return addr;
>>  }
>
>The modifications of `flags' is unneeded (and the compiler will remove
>it).  And generally the modification of incoming args is a bit nasty
>IMO - I find it's better to treat them as const - part of the calling
>environment which can be relied upon to be unaltered as the code
>evolves.
>

To be honest I was just mirroring the rest of the function. I guess
the idea was filtering the different mapping types in case one of the
'mappers' can handle multiple flags or something. I'll remove it if
you like, I just thought that extending the functionality in-keeping
with the current semantics was a better evolution - let me know.

Thanks,
Brian
