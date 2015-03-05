From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 05 Mar 2015 09:36:21 +0100
Subject: [PATCH v5 6/8] pinctrl: cygnus: add gpio/pinconf driver
In-Reply-To: <1425543104.24292.185.camel@x220>
References: <1425515756-321-1-git-send-email-rjui@broadcom.com>
 <1425515756-321-7-git-send-email-rjui@broadcom.com>
 <1425543104.24292.185.camel@x220>
Message-ID: <1425544581.24292.194.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-03-05 at 09:11 +0100, Paul Bolle wrote:
> On Wed, 2015-03-04 at 16:35 -0800, Ray Jui wrote:
> > +MODULE_AUTHOR("Ray Jui <rjui@broadcom.com>");
> > +MODULE_DESCRIPTION("Broadcom Cygnus GPIO Driver");
> > +MODULE_LICENSE("GPL v2");
> 
> These three macros will be preprocessed away. (There's also
> MODULE_DEVICE_TABLE. I don't yet know how that is handled in a
> non-modular build, sorry.)

It turns out MODULE_DEVICE_TABLE is _really_ preprocessed away. See
include/linux/module.h:
    #ifdef MODULE
    /* Creates an alias so file2alias.c can find device table. */
    #define MODULE_DEVICE_TABLE(type, name)                                 \
    extern const typeof(name) __mod_##type##__##name##_device_table         \
      __attribute__ ((unused, alias(__stringify(name))))
    #else  /* !MODULE */
    #define MODULE_DEVICE_TABLE(type, name)
    #endif


Did I get that right?

(I knew the other three MODULE_* macros are handled in slightly more
complicated way, but the effect is basically that they are preprocessed
away.)


Paul Bolle
