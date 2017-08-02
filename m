From: noralf@tronnes.org (=?UTF-8?Q?Noralf_Tr=c3=b8nnes?=)
Date: Wed, 2 Aug 2017 20:49:52 +0200
Subject: [PATCH v2 2/4] drm/tinydrm: add support for LEGO MINDSTORMS EV3
 LCD
In-Reply-To: <3244660b-64f6-8202-b505-a9796b888db5@lechnology.com>
References: <1501625510-16727-1-git-send-email-david@lechnology.com>
 <1501625510-16727-3-git-send-email-david@lechnology.com>
 <32b134d1-84f3-8e3d-1d57-05c8b7c384bc@tronnes.org>
 <3244660b-64f6-8202-b505-a9796b888db5@lechnology.com>
Message-ID: <0d20a6da-5c61-2a75-c372-29fea1b6872e@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 02.08.2017 18.24, skrev David Lechner:
> On 08/02/2017 08:03 AM, Noralf Tr?nnes wrote:
>>
>>
>> Please use tinydrm_xrgb8888_to_gray8().
>
> I considered this, but is seems excessive to loop through the entire 
> fb twice just to make a 4x6 cursor blink.
>

Yes, you're right about that.

Can you change tinydrm_xrgb8888_to_gray8 to match the other
copy/conversion functions so we can pass it a clip rectangle:

int tinydrm_xrgb8888_to_gray8(u8 *dst, void *vaddr,
                 struct drm_framebuffer *fb,
                 struct drm_clip_rect *clip)

And move the import_attach part to the driver (repaper).
repaper doesn't do partial updates, so pass a full clip.

>> You should use this function to enable the regulator and init the
>> controller. Don't look at mi0283qt it should have been fixed.
>
> ACK. But this is why I was not keen on writing a standalone driver. I 
> know some things about kernel development, but not everything. How am 
> I supposed to know what is OK to copy from other drivers and what is not? 

You can't know, and it's part of the review process to sort that out.
That being said, I really should have fixed mi0283qt, because it will
be copied...

> And if I am going to be put down as the maintainer of this driver, it 
> bothers me that I don't know so much about how it all works.
>

You don't need to know all the details. If I make a change, you can
assume that I know what I'm doing and ack it, but I need someone to
look at my patches, I can't apply my own patches without anyone looking
at it, we all make mistakes. And if someone else sends a patch and you
don't know if it is good or not, just ping me and I'll look at it.
Either way I have to look at all tinydrm patches before applying them.
I'm not keen on being default maintainer on drivers that I can't test.
The upside of being a maintainer is that you control the future of the
driver, what changes goes in.

And I'm kind of in the same boat as you, I know tinydrm, but drm is
very complex and I don't know half of what's going on. If I'm stuck or
out of my league, I have to ask for help. Like with adding drm formats.

Noralf.
