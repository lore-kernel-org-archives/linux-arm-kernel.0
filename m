From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Sep 2012 09:17:03 +0200
Subject: [GIT PULL] SPEAr pinctrl updates for v-3.5
In-Reply-To: <20120904041940.GA2037@localhost.localdomain>
References: <1336562136-24498-1-git-send-email-viresh.kumar@st.com>
 <CAOh2x=mGdV_wbJC64wvb9+UV_FBgnsat9=ojD8BJYVxT+HoWhQ@mail.gmail.com>
 <201205122142.02318.arnd@arndb.de>
 <CACRpkdZgSJGcM9cT3yMv1jhUrD9hKXv=VVb1mFSWrMzRPYu-=g@mail.gmail.com>
 <4FB47DE2.4070704@st.com>
 <CACRpkdYGuqg3xy+x+adREEzkPL9RFzDDBaEBttR-HarZ7jWuFA@mail.gmail.com>
 <CAOh2x=kOU=X2V5zBg4G_SWzNSfQyoeygwgW-vO-xxRkDXzZDJQ@mail.gmail.com>
 <CACRpkday9+zhMHWWjNNBfhhQ2NXPc+RoGkHvxodud5HY7hLm4g@mail.gmail.com>
 <CAPub14-CQCXf3pfZqXjHarfMfaYG3Me7aNffFJ3JMYhr8J4osg@mail.gmail.com>
 <CACRpkdZok471mc_XqogZo2orS7aCeMDSz0oxXfncm5HgMv37aw@mail.gmail.com>
 <20120904041940.GA2037@localhost.localdomain>
Message-ID: <CACRpkdZy+zmNYPaAmNhUP4FXaPrz2pfc3PUUaWb4vtE=KSAtGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 4, 2012 at 6:19 AM, Shiraz Hashim <shiraz.hashim@st.com> wrote:
> [Me]
>> So the basic problem with the patch is that you cannot hard-code it
>> to use *only* device tree, it must also accept ranges registered
>> directly, not using of_*.
>
> For describing gpio pin ranges, we need to know corresponding pinctrl
> implementation handling this range, base pin and number of pins
> belonging to the range. Further there can be multiple such ranges for
> a gpio driver.
>
> With devicetree it was easy to provide this information and parse it
> inside gpiolib itself. Without DT how do you suggest gpio drivers must
> pass range information to gpiolib ?

That's the real trick right. You need a key to search pinctrldev_list
in pinctrl/core.c, so use the name of the pinctrl device and
you get a function like this:

void gpiochip_add_pin_range(char *name, struct gpio_chip *chip);

Loop over pinctrldev_list until dev_name(pctldev->dev) == name
then add the range.

The remove function can look like this however:

void gpiochip_remove_pin_range(struct gpio_chip *chip);

In this case you just look for all pin controllers with the matching
gpiochip pointer.

Yours,
Linus Walleij
