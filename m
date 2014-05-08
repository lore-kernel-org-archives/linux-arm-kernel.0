From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Thu, 08 May 2014 11:59:02 +0400
Subject: [PATCH] arm: memset: zero out upper bytes in r1
In-Reply-To: <20140507234255.GA2050@afzal-ThinkPad-R50e>
References: <1399273875-8403-1-git-send-email-a.ryabinin@samsung.com>
 <20140507234255.GA2050@afzal-ThinkPad-R50e>
Message-ID: <536B3946.9070106@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/14 03:42, Afzal Mohammed wrote:
> 
> int is to be converted to unsigned char in memset, would having above
> change immediately upon entry to memset rather than at a place where it
> won't always execute make intention clearer ? (although it doesn't make
> difference)
> 

I think it's better to keep it near other manipulations with r1.
Plus this will save us from executing extra instruction on 'memset -> 6 -> 5 -> return'
path (memset for size <= 3).


> ubfx r1, r1, #0, #8 would have given the needed typecasting, but seems
> it is available only on ARMv6T2 & above.
> 

Indeed. It might be wrapped it with #if #else, but it will be a bit ugly,
probably not worth to do.
