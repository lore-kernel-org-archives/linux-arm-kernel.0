From: peda@axentia.se (Peter Rosin)
Date: Tue, 3 Apr 2018 14:55:36 +0200
Subject: [PATCH] drm/atmel-hlcdc: add command line option to specify
 preferred depth
In-Reply-To: <20180403091037.GO3881@phenom.ffwll.local>
References: <20180326073502.19259-1-peda@axentia.se>
 <20180328093454.4149fa3b@bbrezillon>
 <ce723d9f-6858-0bad-bffb-85ab036510ee@axentia.se>
 <20180403091037.GO3881@phenom.ffwll.local>
Message-ID: <6a0a1730-be02-758f-b411-776b9c751a3d@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-04-03 11:10, Daniel Vetter wrote:
> On Wed, Mar 28, 2018 at 12:03:39PM +0200, Peter Rosin wrote:
>> On 2018-03-28 09:34, Boris Brezillon wrote:
>>> Hi Peter,
>>>
>>> On Mon, 26 Mar 2018 09:35:02 +0200
>>> Peter Rosin <peda@axentia.se> wrote:
>>>
>>>> I have an sama5d31-based system with 64MB of memory and a 1920x1080
>>>> LVDS display wired for 16-bpp. When I enable legacy fbdev support,
>>>> the contiguous memory allocator invariably fails with the order-11
>>>> allocation for a 1920x1080 at 24-bpp buffer (~6MB). But this HW can never
>>>> make any good use of RGB888, so that is a wasted attempt anyway that
>>>> would also waste precious memory should it succeed.
>>>>
>>>> Sure, I could rewrite user-space to go directly to KMS etc, and that
>>>> makes the (attempted) order-11 allocation go away, replacing it with
>>>> one order-10 allocation per application restart for a 1920x1080 at 16-bpp
>>>> buffer (<4MB). But after a few restarts, order-10 allocations start to
>>>> fail as well, which is only to be expected AFAIU.
>>>>
>>>> So, I'd rather not change user-space (which was originally written
>>>> to target a smaller display) so that I at the same time get the
>>>> benefit of an early pre-allocated fbdev frame-buffer that can be
>>>> reused over and over. But to do that I need to tell the driver that
>>>> 16-bpp is the preferred depth. Add a module parameter to do just that.
>>>>
>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>> ---
>>>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 18 +++++++++++++++++-
>>>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>>>
>>>> I found some inspiration regarding naming and implementation here:
>>>> https://patchwork.kernel.org/patch/9848631/
>>>>
>>>> I have found no feedback on that patch though, which makes me wonder if
>>>> I'm perhaps barking up the wronig tree?
>>>
>>> Hm, isn't that something you can already overload with the video=
>>> parameter?
>>>
>>> 	video=<output>:<resolution>[-<bpp>]
>>
>> Heh, you are right...
>>
>>> AFAIR, <bpp> encodes the color depth, so what is the benefit of adding
>>> this new property to overload the default depth?
>>
>> ...but hhhmmm, I think I will have to have to encode the display size
>> in the bootargs so I will have to use distinct barebox environments
>> depending on the panel, but that's no biggie.
>>
>> Splendid, please throw away the patch!
> 
> I think we could fix the parsing to allow -bpp without the resolution ...
> Not sure how to best do that though. Maybe state that 0x0-bpp means to not
> change the resolution from the default?

That could be done, and I had a quick look but it's not immediately obvious
to me how that should be accomplished in a fairly localized manner. Since
this is no big deal, I will leave that as is and simply specify the screen
resolution along with the bpp in the bootargs.

But I do like the idea.

Cheers,
Peter
