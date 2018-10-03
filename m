From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Wed, 3 Oct 2018 14:13:53 +0200
Subject: [PATCH 1/2] drm/sun4i: tcon: fix check of tcon->panel null pointer
In-Reply-To: <CAGb2v64z+j=ywU8n210Zw+97n=Ff4rVdUwNR9nbKO-hMD3nJcQ@mail.gmail.com>
References: <20181001093612.GA13672@mwanda>
 <20181002215917.1849-1-giulio.benetti@micronovasrl.com>
 <CAGb2v64z+j=ywU8n210Zw+97n=Ff4rVdUwNR9nbKO-hMD3nJcQ@mail.gmail.com>
Message-ID: <9a545739-eed5-7af1-3b75-108bdd3427a2@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 03/10/2018 11:43, Chen-Yu Tsai ha scritto:
> On Wed, Oct 3, 2018 at 5:59 AM Giulio Benetti
> <giulio.benetti@micronovasrl.com> wrote:
>>
>> At the moment, the check of tcon->panel to be valid is wrong. IS_ERR()
>> has been used, but that macro doesn't check if tcon->panel pointer is
>> null or not, but check if tcon->panel is between -1 and -4095(MAX_ERRNO).
>>
>> Remove IS_ERR() from tcon->panel checking and let "if (tcon->panel)" as
>> condition to check if it's a pointer not null.
> 
> There's actually more than one occurance of this error:
> 
> drivers/gpu/drm/sun4i/sun4i_lvds.c:     if (!IS_ERR(tcon->panel)) {
> drivers/gpu/drm/sun4i/sun4i_lvds.c:     if (!IS_ERR(tcon->panel)) {
> drivers/gpu/drm/sun4i/sun4i_rgb.c:      if (!IS_ERR(tcon->panel)) {
> drivers/gpu/drm/sun4i/sun4i_rgb.c:      if (!IS_ERR(tcon->panel)) {
> 
> These four are responsible for enabling and disabling the panel.
> 
> drivers/gpu/drm/sun4i/sun4i_tcon.c:     if (!IS_ERR(tcon->panel)) {
> 
> All this looks like it was left over from commit ebc9446135671 ("drm: convert
> drivers to use drm_of_find_panel_or_bridge"). We have checks against tcon->panel
> in several places and not all of them were converted.
> 

Then, I'm going to send a patchset to correct them.

Best regards
-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ? 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
