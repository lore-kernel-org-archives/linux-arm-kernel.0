From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 21 Mar 2016 19:06:05 +0100
Subject: [linux-sunxi] Re: [PATCH v8 2/2] ASoc: sun4i-codec: Add FM, Line
 and Mic inputs
In-Reply-To: <20160319175124.6bfe3617@scratchpost.org>
References: <20151221123148.1ab6480b@dayas> <20151221123416.51aa938e@dayas>
 <20151227182157.GI30359@lukather> <20151228040649.475a742f@dayas>
 <20160106220908.GE9631@lukather> <20160109164832.515d69b0@dayas>
 <20160312085222.226d89bf@scratchpost.org>
 <20160314104939.GL8418@lukather>
 <20160319175124.6bfe3617@scratchpost.org>
Message-ID: <20160321180605.GE30977@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 19, 2016 at 05:51:24PM +0100, Danny Milosavljevic wrote:
> Hi Maxime,
> 
> > IIRC, in order to have shared controls, you just needed to share the
> > controls structure.
> 
> Yeah. I did this and it actually works in a way, but in doesn't do all that I want.
> 
> There are two different kinds of sharing I mean:
> 
> The one kind with the controls structure causes the control to rename itself
> to not state its mixer but there's still just one slider in the end. 
> So instead of "Left Mixer Left XXX" it will just say "Left XXX" if you put it 
> inside Left Mixer and Right Mixer and share the entry - for this hardware, 
> that's of doubtful use.
> 
> But what I would like to have is that the same Mic Playback Volume (the very 
> same bits) be used for different sliders
> (1) Mic1 Left Channel Playback Volume
> (2) Mic1 Right Channel Playback Volume
> (3) Mic2 Left Channel Playback Volume (!!)
> (4) Mic2 Right Channel Playback Volume
> 
> Additionally, Mic1 Playback and Mic2 Playback have two mutes each in the 
> hardware (all separately switchable).
> 
> Now if we could make the alsamixer selems look like the following, 
> that would be nice:
> 
> Mic1_Playback     Mic2_Playback
> 
>   MM                  MM
>   ii                  ii
>   cc                  cc
> 
>   PP                  PP
>   ll                  ll
>   aa                  aa
>   yy                  yy
>   bb                  bb
>   aa                  aa
>   cc                  cc
>   kk                  kk
> 
>   VV                  VV
>   oo                  oo
>   ll                  ll
>   uu                  uu
>   mm                  mm
>   ee                  ee
> 
>  [Mm]                [Nn]
>    ^                  ^^-- so are those, separately
>    +-- this one is a different muter :-)
> 
> Where the text is the same, it's supposed to signify the same bits 
> in the hardware.
> 
> Right now in v8 it's (and that's going to take a lot of horizontal space, 
> sorry - I know E-Mails like this aren't so nice to read):
> 
> Mic_Playback_Volume Left_Mic1_Playback_Switch Right_Mic1_Playback_Switch Left_Mic2_Playback_Switch Right_Mic2_Playback_Switch
> 
>   MM                  
>   ii                  
>   cc                  
> 
>   PP                  
>   ll                  
>   aa                  
>   yy                  
>   bb                  
>   aa                  
>   cc                  
>   kk                  
> 
>   VV                  
>   oo                  
>   ll                  
>   uu                  
>   mm                  
>   ee                  
> 
>                     [MM]                      [NN]                       [OO]                      [PP]
>                       ^- WTF                   ^- WTF                      ^- WTF                   ^- WTF
> 
> (Actually, it's worse - believe it or not, that's how the simplified explanation looks)

I don't think you should focus too much on alsamixer, there's other
tools to modify the configuration.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160321/0f90df5b/attachment.sig>
