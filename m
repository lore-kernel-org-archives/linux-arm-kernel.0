From: dcb314@hotmail.com (David Binderman)
Date: Mon, 4 Jan 2016 17:51:09 +0000
Subject: linux-4.4-rc8/drivers/media/platform/s5p-tv/mixer_video.c:270:
 possible int/long mixup ?
Message-ID: <DUB128-W9112C6EE53B44B5A884EC9CF20@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello there,

[linux-4.4-rc8/drivers/media/platform/s5p-tv/mixer_video.c:270]: (style) int result is returned as long value. If the return value is long to avoid loss of information, then you have loss of information.

Source code is

unsigned long mxr_get_plane_size(const struct mxr_block *blk,
??? unsigned int width, unsigned int height)
{
??? unsigned int bl_width = divup(width, blk->width);
??? unsigned int bl_height = divup(height, blk->height);

??? return bl_width * bl_height * blk->size;
}

Suggest new code

unsigned long mxr_get_plane_size(const struct mxr_block *blk,
??? unsigned int width, unsigned int height)
{
??? unsigned int bl_width = divup(width, blk->width);
??? unsigned int bl_height = divup(height, blk->height);

??? return bl_width * bl_height * (unsigned long) blk->size;
}

Addition of the cast causes both multiplies to be in unsigned long
type, not unsigned int, thus preserving values.


Regards

David Binderman 

 		 	   		  
